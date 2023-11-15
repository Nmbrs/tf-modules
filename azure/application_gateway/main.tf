resource "azurerm_public_ip" "app_gw" {
  name                = local.public_ip_name
  domain_name_label   = local.app_gateway_name
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
  zones               = ["1"]

  lifecycle {
    ignore_changes = [tags]
  }
}

resource "azurerm_application_gateway" "app_gw" {
  name                = local.app_gateway_name
  location            = var.location
  resource_group_name = var.resource_group_name
  enable_http2        = true

  sku {
    name = "WAF_v2"
    tier = "WAF_v2"
  }

  autoscale_configuration {
    min_capacity = var.min_instance_count
    max_capacity = var.max_instance_count
  }

  identity {
    type         = "UserAssigned"
    identity_ids = [data.azurerm_user_assigned_identity.certificate.id]
  }

  waf_configuration {
    enabled          = true
    firewall_mode    = "Prevention"
    rule_set_version = 3.2
  }

  gateway_ip_configuration {
    name      = "app-gateway-ip-configuration"
    subnet_id = data.azurerm_subnet.app_gw.id
  }

  frontend_ip_configuration {
    name                 = azurerm_public_ip.app_gw.name
    public_ip_address_id = azurerm_public_ip.app_gw.id
  }

  # HTTP front end port configuration
  frontend_port {
    name = local.http_frontend_port_name
    port = 80
  }

  # HTTPs front end port configuration
  frontend_port {
    name = local.https_frontend_port_name
    port = 443
  }

  ## TLS / SSL configurations
  ssl_policy {
    #policy_type = "Predefined"
    #policy_name = "AppGwSslPolicy20220101"
    policy_type          = "CustomV2"
    min_protocol_version = "TLSv1_2"
    cipher_suites        = local.cipher_suites
  }

  dynamic "ssl_certificate" {
    for_each = var.certificates
    content {
      name                = ssl_certificate.value.name
      key_vault_secret_id = data.azurerm_key_vault_secret.certificate[ssl_certificate.value.name].id
    }
  }

  ## default configuration
  dynamic "http_listener" {
    #for_each =  local.default_settings
    #for_each = var.application_settings == [] ? local.default_settings : []
    for_each = var.application_settings == [] ? { for index, setting in local.default_settings : index => setting } : {}
    content {
      name                           = "listener-default"
      frontend_ip_configuration_name = azurerm_public_ip.app_gw.name
      frontend_port_name             = local.http_frontend_port_name
      host_name                      = http_listener.value.listener_fqdn
      protocol                       = title(http_listener.value.protocol)
    }
  }

  dynamic "backend_address_pool" {
    #for_each =  local.default_settings
    #for_each = var.application_settings == [] ? local.default_settings : []
    for_each = var.application_settings == [] ? { for index, setting in local.default_settings : index => setting } : {}
    content {
      name = backend_address_pool.value.backend_name
    }
  }

  dynamic "backend_http_settings" {
    #for_each =  local.default_settings
    #for_each = var.application_settings == [] ? local.default_settings : []
    for_each = var.application_settings == [] ? { for index, setting in local.default_settings : index => setting } : {}
    content {
      name                  = backend_http_settings.value.settings_name
      cookie_based_affinity = "Disabled"
      port                  = backend_http_settings.value.port
      protocol              = title(backend_http_settings.value.protocol)
      request_timeout       = 230
    }
  }

  dynamic "request_routing_rule" {
    #for_each =  local.default_settings
    #for_each = var.application_settings == [] ? local.default_settings : []
    for_each = var.application_settings == [] ? { for index, setting in local.default_settings : index => setting } : {}
    content {
      name                       = request_routing_rule.value.rule_name
      priority                   = request_routing_rule.value.rule_priority
      rule_type                  = "Basic"
      http_listener_name         = request_routing_rule.value.listener_name
      backend_address_pool_name  = request_routing_rule.value.backend_name
      backend_http_settings_name = request_routing_rule.value.settings_name
    }
  }

  ## Application configurations
  dynamic "http_listener" {
    #for_each = var.application_settings != [] ? { for idx, setting in var.application_settings : idx => setting } : {}
    for_each = var.application_settings != [] ? var.application_settings : []
    content {
      name                           = "listener-${local.application_transformed_names[http_listener.key]}"
      frontend_ip_configuration_name = azurerm_public_ip.app_gw.name
      frontend_port_name             = http_listener.value.protocol == "https" ? local.https_frontend_port_name : local.http_frontend_port_name
      host_names                     = [http_listener.value.listener_fqdn]
      protocol                       = title(http_listener.value.protocol)
      ssl_certificate_name           = http_listener.value.protocol == "https" ? http_listener.value.certificate_name : null
    }
  }

  dynamic "backend_address_pool" {
    #for_each = var.application_settings != [] ? { for idx, setting in var.application_settings : idx => setting } : {}
    for_each = var.application_settings != [] ? var.application_settings : []
    content {
      name  = "backend-${local.application_transformed_names[backend_address_pool.key]}"
      fqdns = [backend_address_pool.value.backend_fqdn]
    }
  }

  dynamic "probe" {
    #for_each = var.application_settings != [] ? { for idx, setting in var.application_settings : idx => setting } : {}
    for_each = var.application_settings != [] ? var.application_settings : []
    content {
      name                                      = "probe-${local.application_transformed_names[probe.key]}"
      protocol                                  = title(probe.value.protocol)
      path                                      = probe.value.health_probe.path
      port                                      = title(probe.value.health_probe.port)
      pick_host_name_from_backend_http_settings = false
      host                                      = probe.value.backend_fqdn
      timeout                                   = probe.value.health_probe.timeout_in_seconds
      interval                                  = probe.value.health_probe.evaluation_interval_in_seconds
      unhealthy_threshold                       = probe.value.health_probe.unhealthy_treshold_count

      match {
        status_code = ["200-299"]
      }
    }
  }

  dynamic "backend_http_settings" {
    #for_each = var.application_settings != [] ? { for idx, setting in var.application_settings : idx => setting } : {}
    for_each = var.application_settings != [] ? var.application_settings : []
    content {
      name                                = "settings-${local.application_transformed_names[backend_http_settings.key]}"
      cookie_based_affinity               = "Disabled"
      port                                = 443
      protocol                            = "Https"
      request_timeout                     = 230
      probe_name                          = "probe-${local.application_transformed_names[backend_http_settings.key]}"
      pick_host_name_from_backend_address = true
    }
  }

  dynamic "request_routing_rule" {
    #for_each = var.application_settings != [] ? { for idx, setting in var.application_settings : idx => setting } : {}
    for_each = var.application_settings != [] ? var.application_settings : []
    content {
      name                       = "rule-${local.application_transformed_names[request_routing_rule.key]}"
      priority                   = request_routing_rule.value.rule_priority
      rule_type                  = "Basic"
      http_listener_name         = "listener-${local.application_transformed_names[request_routing_rule.key]}"
      backend_address_pool_name  = "backend-${local.application_transformed_names[request_routing_rule.key]}"
      backend_http_settings_name = "settings-${local.application_transformed_names[request_routing_rule.key]}"
    }
  }

  # Redirect configurations
  dynamic "http_listener" {
    #for_each = var.redirect_settings
    # for_each = var.redirect_settings != [] ? { for idx, setting in var.redirect_settings : idx => setting } : {}
    for_each = var.redirect_settings != [] ? var.redirect_settings : []
    content {
      name = "listener-${local.redirect_transformed_names[http_listener.key]}"
      # name                 = "lis-${http_listener.value.protocol}"
      frontend_ip_configuration_name = azurerm_public_ip.app_gw.name
      frontend_port_name             = http_listener.value.protocol == "https" ? local.https_frontend_port_name : local.http_frontend_port_name
      host_names                     = [http_listener.value.listener_fqdn]
      protocol                       = title(http_listener.value.protocol)
      ssl_certificate_name           = http_listener.value.certificate_name
    }
  }

  dynamic "redirect_configuration" {
    #for_each = var.redirect_settings
    #for_each = var.redirect_settings != [] ? { for idx, setting in var.redirect_settings : idx => setting } : {}
    for_each = var.redirect_settings != [] ? var.redirect_settings : []
    content {
      name                 = "redirect-${local.redirect_transformed_names[redirect_configuration.key]}"
      redirect_type        = "Permanent"
      target_url           = redirect_configuration.value.target_url
      include_path         = true
      include_query_string = true
    }
  }

  dynamic "request_routing_rule" {
    #for_each = var.redirect_settings
    #for_each = var.redirect_settings != [] ? { for idx, setting in var.redirect_settings : idx => setting } : {}
    for_each = var.redirect_settings != [] ? var.redirect_settings : []
    content {
      name                        = "rule-${local.redirect_transformed_names[request_routing_rule.key]}"
      priority                    = request_routing_rule.value.rule_priority
      rule_type                   = "Basic"
      http_listener_name          = "listener-${local.redirect_transformed_names[request_routing_rule.key]}"
      redirect_configuration_name = "redirect-${local.redirect_transformed_names[request_routing_rule.key]}"
      # http_listener_name          = "lis-${request_routing_rule.value.protocol}"
      # redirect_configuration_name  = "redirect-${request_routing_rule.value.protocol}"
    }
  }

  lifecycle {
    ignore_changes = [tags]
  }
}
