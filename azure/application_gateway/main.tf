resource "azurerm_public_ip" "application_gateway" {
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
# Application Gateway WAF Policy Configuration
# ==============================================================================

# Default WAF policy for the Application Gateway with all the rules enabled
resource "azurerm_web_application_firewall_policy" "application_gateway" {
  name                = local.waf_policy_name
  resource_group_name = var.resource_group_name
  location            = var.location

  managed_rules {
    managed_rule_set {
      type    = "OWASP"
      version = "3.2"
    }
    managed_rule_set {
      type    = "Microsoft_BotManagerRuleSet"
      version = "1.0"
    }
  }

  policy_settings {
    enabled = true
    mode    = "Detection"
  }

  lifecycle {
    ignore_changes = [tags, managed_rules, custom_rules, policy_settings]
  }

}

# ==============================================================================
# Application Gateway WAF Policy Configuration for each listener
#
# Each listener will have its own WAF policy with all the rules enabled
# by default at deployment time, then later the rules can be customized
# without being managed by Terraform.
# ==============================================================================

# resource "azurerm_web_application_firewall_policy" "listener" {
#   for_each            = { for listener in local.application_names : listener => listener }
#   name                = "waf-${each.key}"
#   resource_group_name = var.resource_group_name
#   location            = var.location

#   managed_rules {
#     managed_rule_set {
#       type    = "OWASP"
#       version = "3.2"
#     }
#     managed_rule_set {
#       type    = "Microsoft_BotManagerRuleSet"
#       version = "1.0"
#     }
#   }

#   policy_settings {
#     enabled = true
#     mode    = "Detection"
#   }

#   lifecycle {
#     ignore_changes = [tags, managed_rules, custom_rules, policy_settings]
#   }
# }

# ==============================================================================
# Application Gateway Configuration
# ==============================================================================

resource "azurerm_application_gateway" "main" {
  name                              = local.app_gateway_name
  location                          = var.location
  resource_group_name               = var.resource_group_name
  enable_http2                      = true
  force_firewall_policy_association = true
  firewall_policy_id                = azurerm_web_application_firewall_policy.application_gateway.id

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
    name                 = azurerm_public_ip.application_gateway.name
    public_ip_address_id = azurerm_public_ip.application_gateway.id
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

  # Security Headers Rewrite Rules
  dynamic "rewrite_rule_set" {
    for_each = (
      length(var.application_backend_settings) != 0 ?
      var.application_backend_settings :
      local.default_application_settings
    )
    content {
      name = "rewrite-rules-${local.application_names[rewrite_rule_set.key]}"

      # HSTS Header - Only if enabled
      dynamic "rewrite_rule" {
        for_each = rewrite_rule_set.value.backend.rewrite_rules.headers.hsts_enabled ? [1] : []
        content {
          name          = "hsts-header"
          rule_sequence = 1

          response_header_configuration {
            header_name  = "Strict-Transport-Security"
            header_value = "max-age=31536000; includeSubdomains; preload"
          }
        }
      }

      # CSP Header - Only if enabled
      dynamic "rewrite_rule" {
        for_each = rewrite_rule_set.value.backend.rewrite_rules.headers.csp_enabled ? [1] : []
        content {
          name          = "csp-header"
          rule_sequence = 2

          response_header_configuration {
            header_name  = "Content-Security-Policy"
            header_value = "default-src 'self'; script-src 'self'; style-src 'self'; img-src 'self' data: https:; font-src 'self' data:; connect-src 'self'; frame-ancestors 'none'; base-uri 'self'; form-action 'self';"
          }
        }
      }

      # X-Frame-Options Header - Only if enabled
      dynamic "rewrite_rule" {
        for_each = rewrite_rule_set.value.backend.rewrite_rules.headers.x_frame_options_enabled ? [1] : []
        content {
          name          = "x-frame-options-headers"
          rule_sequence = 3

          response_header_configuration {
            header_name  = "X-Frame-Options"
            header_value = "DENY"
          }
        }
      }

      # X-Content-Type-Options Header - Only if enabled
      dynamic "rewrite_rule" {
        for_each = rewrite_rule_set.value.backend.rewrite_rules.headers.x_content_type_options_enabled ? [1] : []
        content {
          name          = "x-content-type-options-headers"
          rule_sequence = 4

          response_header_configuration {
            header_name  = "X-Content-Type-Options"
            header_value = "nosniff"
          }
        }
      }


      # X-XSS-Protection Header - Only if enabled
      dynamic "rewrite_rule" {
        for_each = rewrite_rule_set.value.backend.rewrite_rules.headers.x_xss_protection_enabled ? [1] : []
        content {
          name          = "x-xss-protection-headers"
          rule_sequence = 5

          response_header_configuration {
            header_name  = "X-XSS-Protection"
            header_value = "1; mode=block"
          }
        }
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
      frontend_ip_configuration_name = azurerm_public_ip.application_gateway.name
      frontend_port_name             = http_listener.value.listener.protocol == "https" ? local.https_frontend_port_name : local.http_frontend_port_name
      host_names                     = [http_listener.value.listener.fqdn]
      protocol                       = title(http_listener.value.listener.protocol)
      ssl_certificate_name           = http_listener.value.listener.protocol == "https" ? http_listener.value.listener.certificate_name : null
      firewall_policy_id             = null#azurerm_web_application_firewall_policy.listener[local.application_names[http_listener.key]].id
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
      port                                      = probe.value.backend.port
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
      affinity_cookie_name                = backend_http_settings.value.backend.cookie_based_affinity_enabled ? "ApplicationGatewayAffinity" : null # ApplicationGatewayAffinity is the Default cookie name
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
      rewrite_rule_set_name      = "rewrite-rules-${local.application_names[request_routing_rule.key]}"
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
      frontend_ip_configuration_name = azurerm_public_ip.application_gateway.name
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
      frontend_ip_configuration_name = azurerm_public_ip.application_gateway.name
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

    ## Naming validation: Ensure either override_name is provided OR all naming components are provided
    precondition {
      condition = var.override_name != null || (
        var.workload != null &&
        var.company_prefix != null &&
        var.sequence_number != null
      )
      error_message = "Invalid naming configuration: Either 'override_name' must be provided, or all of 'workload', 'company_prefix', and 'sequence_number' must be provided for automatic naming."
    }
  }
}

# ==============================================================================
# Application Gateway Logs
# ==============================================================================
resource "azurerm_monitor_diagnostic_setting" "app_gateway" {
  name                       = "diag-${local.app_gateway_name}"
  target_resource_id         = azurerm_application_gateway.main.id
  log_analytics_workspace_id = data.azurerm_log_analytics_workspace.diagnostics.id

  dynamic "enabled_log" {
    for_each = try(var.diagnostic_settings.logs.access_log_enabled, true) ? ["ApplicationGatewayAccessLog"] : []
    content {
      category = enabled_log.value
    }
  }

  dynamic "enabled_log" {
    for_each = try(var.diagnostic_settings.logs.performance_log_enabled, true) ? ["ApplicationGatewayPerformanceLog"] : []
    content {
      category = enabled_log.value
    }
  }

  dynamic "enabled_log" {
    for_each = try(var.diagnostic_settings.logs.firewall_log_enabled, true) ? ["ApplicationGatewayFirewallLog"] : []
    content {
      category = enabled_log.value
    }
  }

  metric {
    category = "AllMetrics"
    enabled  = var.diagnostic_settings.metrics_enabled
  }
}
