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
    min_capacity = var.min_capacity
    max_capacity = var.max_capacity
  }

  gateway_ip_configuration {
    name      = "app-gateway-ip-configuration"
    subnet_id = data.azurerm_subnet.app_gw.id
  }

  ssl_policy {
    policy_type = "Predefined"
    policy_name = "AppGwSslPolicy20220101"
  }

  frontend_port {
    name = "https-frontend-port"
    port = 443
  }

  frontend_port {
    name = "http-frontend-port"
    port = 80
  }

  frontend_ip_configuration {
    name                 = azurerm_public_ip.app_gw.name
    public_ip_address_id = azurerm_public_ip.app_gw.id
  }

  identity {
    type         = "UserAssigned"
    identity_ids = [data.azurerm_user_assigned_identity.certificate.id]
  }

  ssl_certificate {
    name                = var.certificate_display_name
    key_vault_secret_id = data.azurerm_key_vault_secret.certificate.id
  }

  waf_configuration {
    enabled          = true
    firewall_mode    = "Prevention"
    rule_set_version = 3.2
  }


  dynamic "http_listener" {
    for_each = var.application_name
    content {
      name                           = http_listener.value.protocol == "Https" ? "${http_listener.value.name}-https" : "${http_listener.value.name}-http"
      frontend_ip_configuration_name = azurerm_public_ip.app_gw.name
      frontend_port_name             = http_listener.value.protocol == "Https" ? "https-frontend-port" : "http-frontend-port"
      host_name                      = http_listener.value.fqdn
      protocol                       = http_listener.value.protocol
      ssl_certificate_name           = http_listener.value.protocol == "Https" ? var.certificate_display_name : null
    }
  }

  dynamic "backend_address_pool" {
    for_each = var.application_name
    content {
      name  = backend_address_pool.value.name
      fqdns = [backend_address_pool.value.fqdn]
    }
  }

  dynamic "backend_http_settings" {
    for_each = var.application_name
    content {
      name                  = backend_http_settings.value.name
      cookie_based_affinity = "Disabled"
      port                  = 443
      protocol              = "Https"
      request_timeout       = 230
    }
  }


  dynamic "request_routing_rule" {
    for_each = var.application_name
    content {
      name                       = request_routing_rule.value.protocol == "Https" ? "${request_routing_rule.value.name}-https" : "${request_routing_rule.value.name}-http"
      priority                   = request_routing_rule.value.priority
      rule_type                  = "Basic"
      http_listener_name         = request_routing_rule.value.protocol == "Https" ? "${request_routing_rule.value.name}-https" : "${request_routing_rule.value.name}-http"
      backend_address_pool_name  = request_routing_rule.value.name
      backend_http_settings_name = request_routing_rule.value.name
    }
  }

  lifecycle {
    ignore_changes = [tags]
  }
}
