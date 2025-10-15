resource "azurerm_public_ip" "app_gw" {
  name                = local.public_ip_name
  domain_name_label   = local.app_gateway_dns_label
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"

  lifecycle {
    ignore_changes = [tags]
  }
}

# ==============================================================================
# Application Gateway Configuration
# ==============================================================================

resource "azurerm_application_gateway" "app_gw" {
  name                = local.app_gateway_name
  location            = var.location
  resource_group_name = var.resource_group_name
  enable_http2        = true
  force_firewall_policy_association = (
    var.waf_policy_settings != "" && var.waf_policy_settings != null ? true : null
  )
  firewall_policy_id = (
    var.waf_policy_settings != "" && var.waf_policy_settings != null ?
    data.azurerm_web_application_firewall_policy.waf_policy_settings[0].id :
    null
  )

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

  frontend_port {
    name = local.http_frontend_port_name
    port = local.http_port
  }

  frontend_port {
    name = local.https_frontend_port_name
    port = local.https_port
  }

  ssl_policy {
    policy_type          = "Custom"
    min_protocol_version = "TLSv1_2"
    cipher_suites        = local.cipher_suites
  }

  # SSL Certificates
  dynamic "ssl_certificate" {
    for_each = var.ssl_certificates
    content {
      name                = ssl_certificate.value.name
      key_vault_secret_id = data.azurerm_key_vault_secret.certificate[ssl_certificate.value.name].versionless_id
    }
  }

  # Security
  rewrite_rule_set {
    name = "security"
    rewrite_rule {
      name = "hsts"
      rule_sequence = 1

      response_header_configuration {
        header_name = "Strict-Transport-Security"
        header_value = "max-age=31536000; includeSubdomains; preload"
      }
    }
  }

  # Application Backend Configuration
  dynamic "http_listener" {
    for_each = (
      length(var.application_backend_settings) != 0 ?
      var.application_backend_settings :
      local.default_application_settings
    )
    content {
      name                           = "listener-${local.application_names[http_listener.key]}"
      frontend_ip_configuration_name = azurerm_public_ip.app_gw.name
      frontend_port_name             = http_listener.value.listener.protocol == "https" ? local.https_frontend_port_name : local.http_frontend_port_name
      host_names                     = [http_listener.value.listener.fqdn]
      protocol                       = title(http_listener.value.listener.protocol)
      ssl_certificate_name           = http_listener.value.listener.protocol == "https" ? http_listener.value.listener.certificate_name : null
    }
  }

  dynamic "backend_address_pool" {
    for_each = (
      length(var.application_backend_settings) != 0 ?
      var.application_backend_settings :
      local.default_application_settings
    )

    content {
      name  = "backend-${local.application_names[backend_address_pool.key]}"
      fqdns = backend_address_pool.value.backend.fqdns
    }
  }

  dynamic "probe" {
    for_each = (
      length(var.application_backend_settings) != 0 ?
      var.application_backend_settings :
      local.default_application_settings
    )
    content {
      name                                      = "probe-${local.application_names[probe.key]}"
      protocol                                  = title(probe.value.backend.protocol)
      path                                      = probe.value.backend.health_probe.path
      port                                      = title(probe.value.backend.port)
      pick_host_name_from_backend_http_settings = false
      host                                      = probe.value.backend.health_probe.fqdn
      timeout                                   = probe.value.backend.health_probe.timeout_in_seconds
      interval                                  = probe.value.backend.health_probe.evaluation_interval_in_seconds
      unhealthy_threshold                       = probe.value.backend.health_probe.unhealthy_treshold_count

      match {
        status_code = probe.value.backend.health_probe.status_codes
      }
    }
  }

  dynamic "backend_http_settings" {
    for_each = (
      length(var.application_backend_settings) != 0 ?
      var.application_backend_settings :
      local.default_application_settings
    )
    content {
      name                                = "settings-${local.application_names[backend_http_settings.key]}"
      cookie_based_affinity               = backend_http_settings.value.backend.cookie_based_affinity_enabled ? "Enabled" : "Disabled"
      port                                = backend_http_settings.value.backend.port
      protocol                            = title(backend_http_settings.value.backend.protocol)
      request_timeout                     = backend_http_settings.value.backend.request_timeout_in_seconds
      probe_name                          = "probe-${local.application_names[backend_http_settings.key]}"
      pick_host_name_from_backend_address = false
    }
  }

  dynamic "request_routing_rule" {
    for_each = (
      length(var.application_backend_settings) != 0 ?
      var.application_backend_settings :
      local.default_application_settings
    )
    content {
      name                       = "rule-${local.application_names[request_routing_rule.key]}"
      priority                   = request_routing_rule.value.routing_rule.priority
      rule_type                  = "Basic"
      http_listener_name         = "listener-${local.application_names[request_routing_rule.key]}"
      backend_address_pool_name  = "backend-${local.application_names[request_routing_rule.key]}"
      backend_http_settings_name = "settings-${local.application_names[request_routing_rule.key]}"
    }
  }

  # Redirect URL Configuration
  dynamic "http_listener" {
    for_each = (
      length(var.redirect_url_settings) != 0 ?
      var.redirect_url_settings :
      []
    )
    content {
      name                           = "listener-${local.redirect_url_names[http_listener.key]}"
      frontend_ip_configuration_name = azurerm_public_ip.app_gw.name
      frontend_port_name             = http_listener.value.listener.protocol == "https" ? local.https_frontend_port_name : local.http_frontend_port_name
      host_names                     = [http_listener.value.listener.fqdn]
      protocol                       = title(http_listener.value.listener.protocol)
      ssl_certificate_name           = http_listener.value.listener.certificate_name
    }
  }

  dynamic "redirect_configuration" {
    for_each = (
      length(var.redirect_url_settings) != 0 ?
      var.redirect_url_settings :
      []
    )
    content {
      name                 = "redirect-${local.redirect_url_names[redirect_configuration.key]}"
      redirect_type        = "Permanent"
      target_url           = redirect_configuration.value.target.url
      include_path         = redirect_configuration.value.target.include_path
      include_query_string = redirect_configuration.value.target.include_query_string
    }
  }

  dynamic "request_routing_rule" {
    for_each = (
      length(var.redirect_url_settings) != 0 ?
      var.redirect_url_settings :
      []
    )
    content {
      name                        = "rule-${local.redirect_url_names[request_routing_rule.key]}"
      priority                    = request_routing_rule.value.routing_rule.priority
      rule_type                   = "Basic"
      http_listener_name          = "listener-${local.redirect_url_names[request_routing_rule.key]}"
      redirect_configuration_name = "redirect-${local.redirect_url_names[request_routing_rule.key]}"
    }
  }

  # Redirect Listener Configuration
  dynamic "http_listener" {
    for_each = (
      length(var.redirect_listener_settings) != 0 ?
      var.redirect_listener_settings :
      []
    )
    content {
      name                           = "listener-${local.redirect_listener_names[http_listener.key]}"
      frontend_ip_configuration_name = azurerm_public_ip.app_gw.name
      frontend_port_name             = http_listener.value.listener.protocol == "https" ? local.https_frontend_port_name : local.http_frontend_port_name
      host_names                     = [http_listener.value.listener.fqdn]
      protocol                       = title(http_listener.value.listener.protocol)
      ssl_certificate_name           = http_listener.value.listener.certificate_name
    }
  }

  dynamic "redirect_configuration" {
    for_each = (
      length(var.redirect_listener_settings) != 0 ?
      var.redirect_listener_settings :
      []
    )
    content {
      name                 = "redirect-${local.redirect_listener_names[redirect_configuration.key]}"
      redirect_type        = "Permanent"
      target_listener_name = redirect_configuration.value.target.listener_name
      include_path         = redirect_configuration.value.target.include_path
      include_query_string = redirect_configuration.value.target.include_query_string
    }
  }

  dynamic "request_routing_rule" {
    for_each = (
      length(var.redirect_listener_settings) != 0 ?
      var.redirect_listener_settings :
      []
    )
    content {
      name                        = "rule-${local.redirect_listener_names[request_routing_rule.key]}"
      priority                    = request_routing_rule.value.routing_rule.priority
      rule_type                   = "Basic"
      http_listener_name          = "listener-${local.redirect_listener_names[request_routing_rule.key]}"
      redirect_configuration_name = "redirect-${local.redirect_listener_names[request_routing_rule.key]}"
    }
  }

  lifecycle {
    ignore_changes = [tags, waf_configuration]

    ## Instance count validation
    precondition {
      condition     = var.min_instance_count <= var.max_instance_count
      error_message = format("Invalid configuration: minimum instance count (%s) must be less than or equal to maximum instance count (%s).", var.min_instance_count, var.max_instance_count)
    }
  }
}
