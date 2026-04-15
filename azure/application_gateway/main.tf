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

resource "azurerm_web_application_firewall_policy" "listener" {
  for_each            = { for listener in local.application_names : listener => listener }
  name                = "waf-${each.key}"
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

  # Rewrite Rule Sets - one empty set per listener, rules managed externally
  dynamic "rewrite_rule_set" {
    for_each = (
      length(var.application_backend_settings) != 0 ?
      var.application_backend_settings :
      local.default_application_settings
    )
    content {
      name = "rewrite-rules-${local.application_names[rewrite_rule_set.key]}"
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
      firewall_policy_id             = azurerm_web_application_firewall_policy.listener[local.application_names[http_listener.key]].id
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
    ignore_changes = [
      tags,
      waf_configuration,
      # Rewrite rules within each set are managed externally — ignore indices 0-499
      rewrite_rule_set[0].rewrite_rule,
      rewrite_rule_set[1].rewrite_rule,
      rewrite_rule_set[2].rewrite_rule,
      rewrite_rule_set[3].rewrite_rule,
      rewrite_rule_set[4].rewrite_rule,
      rewrite_rule_set[5].rewrite_rule,
      rewrite_rule_set[6].rewrite_rule,
      rewrite_rule_set[7].rewrite_rule,
      rewrite_rule_set[8].rewrite_rule,
      rewrite_rule_set[9].rewrite_rule,
      rewrite_rule_set[10].rewrite_rule,
      rewrite_rule_set[11].rewrite_rule,
      rewrite_rule_set[12].rewrite_rule,
      rewrite_rule_set[13].rewrite_rule,
      rewrite_rule_set[14].rewrite_rule,
      rewrite_rule_set[15].rewrite_rule,
      rewrite_rule_set[16].rewrite_rule,
      rewrite_rule_set[17].rewrite_rule,
      rewrite_rule_set[18].rewrite_rule,
      rewrite_rule_set[19].rewrite_rule,
      rewrite_rule_set[20].rewrite_rule,
      rewrite_rule_set[21].rewrite_rule,
      rewrite_rule_set[22].rewrite_rule,
      rewrite_rule_set[23].rewrite_rule,
      rewrite_rule_set[24].rewrite_rule,
      rewrite_rule_set[25].rewrite_rule,
      rewrite_rule_set[26].rewrite_rule,
      rewrite_rule_set[27].rewrite_rule,
      rewrite_rule_set[28].rewrite_rule,
      rewrite_rule_set[29].rewrite_rule,
      rewrite_rule_set[30].rewrite_rule,
      rewrite_rule_set[31].rewrite_rule,
      rewrite_rule_set[32].rewrite_rule,
      rewrite_rule_set[33].rewrite_rule,
      rewrite_rule_set[34].rewrite_rule,
      rewrite_rule_set[35].rewrite_rule,
      rewrite_rule_set[36].rewrite_rule,
      rewrite_rule_set[37].rewrite_rule,
      rewrite_rule_set[38].rewrite_rule,
      rewrite_rule_set[39].rewrite_rule,
      rewrite_rule_set[40].rewrite_rule,
      rewrite_rule_set[41].rewrite_rule,
      rewrite_rule_set[42].rewrite_rule,
      rewrite_rule_set[43].rewrite_rule,
      rewrite_rule_set[44].rewrite_rule,
      rewrite_rule_set[45].rewrite_rule,
      rewrite_rule_set[46].rewrite_rule,
      rewrite_rule_set[47].rewrite_rule,
      rewrite_rule_set[48].rewrite_rule,
      rewrite_rule_set[49].rewrite_rule,
      rewrite_rule_set[50].rewrite_rule,
      rewrite_rule_set[51].rewrite_rule,
      rewrite_rule_set[52].rewrite_rule,
      rewrite_rule_set[53].rewrite_rule,
      rewrite_rule_set[54].rewrite_rule,
      rewrite_rule_set[55].rewrite_rule,
      rewrite_rule_set[56].rewrite_rule,
      rewrite_rule_set[57].rewrite_rule,
      rewrite_rule_set[58].rewrite_rule,
      rewrite_rule_set[59].rewrite_rule,
      rewrite_rule_set[60].rewrite_rule,
      rewrite_rule_set[61].rewrite_rule,
      rewrite_rule_set[62].rewrite_rule,
      rewrite_rule_set[63].rewrite_rule,
      rewrite_rule_set[64].rewrite_rule,
      rewrite_rule_set[65].rewrite_rule,
      rewrite_rule_set[66].rewrite_rule,
      rewrite_rule_set[67].rewrite_rule,
      rewrite_rule_set[68].rewrite_rule,
      rewrite_rule_set[69].rewrite_rule,
      rewrite_rule_set[70].rewrite_rule,
      rewrite_rule_set[71].rewrite_rule,
      rewrite_rule_set[72].rewrite_rule,
      rewrite_rule_set[73].rewrite_rule,
      rewrite_rule_set[74].rewrite_rule,
      rewrite_rule_set[75].rewrite_rule,
      rewrite_rule_set[76].rewrite_rule,
      rewrite_rule_set[77].rewrite_rule,
      rewrite_rule_set[78].rewrite_rule,
      rewrite_rule_set[79].rewrite_rule,
      rewrite_rule_set[80].rewrite_rule,
      rewrite_rule_set[81].rewrite_rule,
      rewrite_rule_set[82].rewrite_rule,
      rewrite_rule_set[83].rewrite_rule,
      rewrite_rule_set[84].rewrite_rule,
      rewrite_rule_set[85].rewrite_rule,
      rewrite_rule_set[86].rewrite_rule,
      rewrite_rule_set[87].rewrite_rule,
      rewrite_rule_set[88].rewrite_rule,
      rewrite_rule_set[89].rewrite_rule,
      rewrite_rule_set[90].rewrite_rule,
      rewrite_rule_set[91].rewrite_rule,
      rewrite_rule_set[92].rewrite_rule,
      rewrite_rule_set[93].rewrite_rule,
      rewrite_rule_set[94].rewrite_rule,
      rewrite_rule_set[95].rewrite_rule,
      rewrite_rule_set[96].rewrite_rule,
      rewrite_rule_set[97].rewrite_rule,
      rewrite_rule_set[98].rewrite_rule,
      rewrite_rule_set[99].rewrite_rule,
      rewrite_rule_set[100].rewrite_rule,
      rewrite_rule_set[101].rewrite_rule,
      rewrite_rule_set[102].rewrite_rule,
      rewrite_rule_set[103].rewrite_rule,
      rewrite_rule_set[104].rewrite_rule,
      rewrite_rule_set[105].rewrite_rule,
      rewrite_rule_set[106].rewrite_rule,
      rewrite_rule_set[107].rewrite_rule,
      rewrite_rule_set[108].rewrite_rule,
      rewrite_rule_set[109].rewrite_rule,
      rewrite_rule_set[110].rewrite_rule,
      rewrite_rule_set[111].rewrite_rule,
      rewrite_rule_set[112].rewrite_rule,
      rewrite_rule_set[113].rewrite_rule,
      rewrite_rule_set[114].rewrite_rule,
      rewrite_rule_set[115].rewrite_rule,
      rewrite_rule_set[116].rewrite_rule,
      rewrite_rule_set[117].rewrite_rule,
      rewrite_rule_set[118].rewrite_rule,
      rewrite_rule_set[119].rewrite_rule,
      rewrite_rule_set[120].rewrite_rule,
      rewrite_rule_set[121].rewrite_rule,
      rewrite_rule_set[122].rewrite_rule,
      rewrite_rule_set[123].rewrite_rule,
      rewrite_rule_set[124].rewrite_rule,
      rewrite_rule_set[125].rewrite_rule,
      rewrite_rule_set[126].rewrite_rule,
      rewrite_rule_set[127].rewrite_rule,
      rewrite_rule_set[128].rewrite_rule,
      rewrite_rule_set[129].rewrite_rule,
      rewrite_rule_set[130].rewrite_rule,
      rewrite_rule_set[131].rewrite_rule,
      rewrite_rule_set[132].rewrite_rule,
      rewrite_rule_set[133].rewrite_rule,
      rewrite_rule_set[134].rewrite_rule,
      rewrite_rule_set[135].rewrite_rule,
      rewrite_rule_set[136].rewrite_rule,
      rewrite_rule_set[137].rewrite_rule,
      rewrite_rule_set[138].rewrite_rule,
      rewrite_rule_set[139].rewrite_rule,
      rewrite_rule_set[140].rewrite_rule,
      rewrite_rule_set[141].rewrite_rule,
      rewrite_rule_set[142].rewrite_rule,
      rewrite_rule_set[143].rewrite_rule,
      rewrite_rule_set[144].rewrite_rule,
      rewrite_rule_set[145].rewrite_rule,
      rewrite_rule_set[146].rewrite_rule,
      rewrite_rule_set[147].rewrite_rule,
      rewrite_rule_set[148].rewrite_rule,
      rewrite_rule_set[149].rewrite_rule,
      rewrite_rule_set[150].rewrite_rule,
      rewrite_rule_set[151].rewrite_rule,
      rewrite_rule_set[152].rewrite_rule,
      rewrite_rule_set[153].rewrite_rule,
      rewrite_rule_set[154].rewrite_rule,
      rewrite_rule_set[155].rewrite_rule,
      rewrite_rule_set[156].rewrite_rule,
      rewrite_rule_set[157].rewrite_rule,
      rewrite_rule_set[158].rewrite_rule,
      rewrite_rule_set[159].rewrite_rule,
      rewrite_rule_set[160].rewrite_rule,
      rewrite_rule_set[161].rewrite_rule,
      rewrite_rule_set[162].rewrite_rule,
      rewrite_rule_set[163].rewrite_rule,
      rewrite_rule_set[164].rewrite_rule,
      rewrite_rule_set[165].rewrite_rule,
      rewrite_rule_set[166].rewrite_rule,
      rewrite_rule_set[167].rewrite_rule,
      rewrite_rule_set[168].rewrite_rule,
      rewrite_rule_set[169].rewrite_rule,
      rewrite_rule_set[170].rewrite_rule,
      rewrite_rule_set[171].rewrite_rule,
      rewrite_rule_set[172].rewrite_rule,
      rewrite_rule_set[173].rewrite_rule,
      rewrite_rule_set[174].rewrite_rule,
      rewrite_rule_set[175].rewrite_rule,
      rewrite_rule_set[176].rewrite_rule,
      rewrite_rule_set[177].rewrite_rule,
      rewrite_rule_set[178].rewrite_rule,
      rewrite_rule_set[179].rewrite_rule,
      rewrite_rule_set[180].rewrite_rule,
      rewrite_rule_set[181].rewrite_rule,
      rewrite_rule_set[182].rewrite_rule,
      rewrite_rule_set[183].rewrite_rule,
      rewrite_rule_set[184].rewrite_rule,
      rewrite_rule_set[185].rewrite_rule,
      rewrite_rule_set[186].rewrite_rule,
      rewrite_rule_set[187].rewrite_rule,
      rewrite_rule_set[188].rewrite_rule,
      rewrite_rule_set[189].rewrite_rule,
      rewrite_rule_set[190].rewrite_rule,
      rewrite_rule_set[191].rewrite_rule,
      rewrite_rule_set[192].rewrite_rule,
      rewrite_rule_set[193].rewrite_rule,
      rewrite_rule_set[194].rewrite_rule,
      rewrite_rule_set[195].rewrite_rule,
      rewrite_rule_set[196].rewrite_rule,
      rewrite_rule_set[197].rewrite_rule,
      rewrite_rule_set[198].rewrite_rule,
      rewrite_rule_set[199].rewrite_rule,
      rewrite_rule_set[200].rewrite_rule,
      rewrite_rule_set[201].rewrite_rule,
      rewrite_rule_set[202].rewrite_rule,
      rewrite_rule_set[203].rewrite_rule,
      rewrite_rule_set[204].rewrite_rule,
      rewrite_rule_set[205].rewrite_rule,
      rewrite_rule_set[206].rewrite_rule,
      rewrite_rule_set[207].rewrite_rule,
      rewrite_rule_set[208].rewrite_rule,
      rewrite_rule_set[209].rewrite_rule,
      rewrite_rule_set[210].rewrite_rule,
      rewrite_rule_set[211].rewrite_rule,
      rewrite_rule_set[212].rewrite_rule,
      rewrite_rule_set[213].rewrite_rule,
      rewrite_rule_set[214].rewrite_rule,
      rewrite_rule_set[215].rewrite_rule,
      rewrite_rule_set[216].rewrite_rule,
      rewrite_rule_set[217].rewrite_rule,
      rewrite_rule_set[218].rewrite_rule,
      rewrite_rule_set[219].rewrite_rule,
      rewrite_rule_set[220].rewrite_rule,
      rewrite_rule_set[221].rewrite_rule,
      rewrite_rule_set[222].rewrite_rule,
      rewrite_rule_set[223].rewrite_rule,
      rewrite_rule_set[224].rewrite_rule,
      rewrite_rule_set[225].rewrite_rule,
      rewrite_rule_set[226].rewrite_rule,
      rewrite_rule_set[227].rewrite_rule,
      rewrite_rule_set[228].rewrite_rule,
      rewrite_rule_set[229].rewrite_rule,
      rewrite_rule_set[230].rewrite_rule,
      rewrite_rule_set[231].rewrite_rule,
      rewrite_rule_set[232].rewrite_rule,
      rewrite_rule_set[233].rewrite_rule,
      rewrite_rule_set[234].rewrite_rule,
      rewrite_rule_set[235].rewrite_rule,
      rewrite_rule_set[236].rewrite_rule,
      rewrite_rule_set[237].rewrite_rule,
      rewrite_rule_set[238].rewrite_rule,
      rewrite_rule_set[239].rewrite_rule,
      rewrite_rule_set[240].rewrite_rule,
      rewrite_rule_set[241].rewrite_rule,
      rewrite_rule_set[242].rewrite_rule,
      rewrite_rule_set[243].rewrite_rule,
      rewrite_rule_set[244].rewrite_rule,
      rewrite_rule_set[245].rewrite_rule,
      rewrite_rule_set[246].rewrite_rule,
      rewrite_rule_set[247].rewrite_rule,
      rewrite_rule_set[248].rewrite_rule,
      rewrite_rule_set[249].rewrite_rule,
      rewrite_rule_set[250].rewrite_rule,
      rewrite_rule_set[251].rewrite_rule,
      rewrite_rule_set[252].rewrite_rule,
      rewrite_rule_set[253].rewrite_rule,
      rewrite_rule_set[254].rewrite_rule,
      rewrite_rule_set[255].rewrite_rule,
      rewrite_rule_set[256].rewrite_rule,
      rewrite_rule_set[257].rewrite_rule,
      rewrite_rule_set[258].rewrite_rule,
      rewrite_rule_set[259].rewrite_rule,
      rewrite_rule_set[260].rewrite_rule,
      rewrite_rule_set[261].rewrite_rule,
      rewrite_rule_set[262].rewrite_rule,
      rewrite_rule_set[263].rewrite_rule,
      rewrite_rule_set[264].rewrite_rule,
      rewrite_rule_set[265].rewrite_rule,
      rewrite_rule_set[266].rewrite_rule,
      rewrite_rule_set[267].rewrite_rule,
      rewrite_rule_set[268].rewrite_rule,
      rewrite_rule_set[269].rewrite_rule,
      rewrite_rule_set[270].rewrite_rule,
      rewrite_rule_set[271].rewrite_rule,
      rewrite_rule_set[272].rewrite_rule,
      rewrite_rule_set[273].rewrite_rule,
      rewrite_rule_set[274].rewrite_rule,
      rewrite_rule_set[275].rewrite_rule,
      rewrite_rule_set[276].rewrite_rule,
      rewrite_rule_set[277].rewrite_rule,
      rewrite_rule_set[278].rewrite_rule,
      rewrite_rule_set[279].rewrite_rule,
      rewrite_rule_set[280].rewrite_rule,
      rewrite_rule_set[281].rewrite_rule,
      rewrite_rule_set[282].rewrite_rule,
      rewrite_rule_set[283].rewrite_rule,
      rewrite_rule_set[284].rewrite_rule,
      rewrite_rule_set[285].rewrite_rule,
      rewrite_rule_set[286].rewrite_rule,
      rewrite_rule_set[287].rewrite_rule,
      rewrite_rule_set[288].rewrite_rule,
      rewrite_rule_set[289].rewrite_rule,
      rewrite_rule_set[290].rewrite_rule,
      rewrite_rule_set[291].rewrite_rule,
      rewrite_rule_set[292].rewrite_rule,
      rewrite_rule_set[293].rewrite_rule,
      rewrite_rule_set[294].rewrite_rule,
      rewrite_rule_set[295].rewrite_rule,
      rewrite_rule_set[296].rewrite_rule,
      rewrite_rule_set[297].rewrite_rule,
      rewrite_rule_set[298].rewrite_rule,
      rewrite_rule_set[299].rewrite_rule,
      rewrite_rule_set[300].rewrite_rule,
      rewrite_rule_set[301].rewrite_rule,
      rewrite_rule_set[302].rewrite_rule,
      rewrite_rule_set[303].rewrite_rule,
      rewrite_rule_set[304].rewrite_rule,
      rewrite_rule_set[305].rewrite_rule,
      rewrite_rule_set[306].rewrite_rule,
      rewrite_rule_set[307].rewrite_rule,
      rewrite_rule_set[308].rewrite_rule,
      rewrite_rule_set[309].rewrite_rule,
      rewrite_rule_set[310].rewrite_rule,
      rewrite_rule_set[311].rewrite_rule,
      rewrite_rule_set[312].rewrite_rule,
      rewrite_rule_set[313].rewrite_rule,
      rewrite_rule_set[314].rewrite_rule,
      rewrite_rule_set[315].rewrite_rule,
      rewrite_rule_set[316].rewrite_rule,
      rewrite_rule_set[317].rewrite_rule,
      rewrite_rule_set[318].rewrite_rule,
      rewrite_rule_set[319].rewrite_rule,
      rewrite_rule_set[320].rewrite_rule,
      rewrite_rule_set[321].rewrite_rule,
      rewrite_rule_set[322].rewrite_rule,
      rewrite_rule_set[323].rewrite_rule,
      rewrite_rule_set[324].rewrite_rule,
      rewrite_rule_set[325].rewrite_rule,
      rewrite_rule_set[326].rewrite_rule,
      rewrite_rule_set[327].rewrite_rule,
      rewrite_rule_set[328].rewrite_rule,
      rewrite_rule_set[329].rewrite_rule,
      rewrite_rule_set[330].rewrite_rule,
      rewrite_rule_set[331].rewrite_rule,
      rewrite_rule_set[332].rewrite_rule,
      rewrite_rule_set[333].rewrite_rule,
      rewrite_rule_set[334].rewrite_rule,
      rewrite_rule_set[335].rewrite_rule,
      rewrite_rule_set[336].rewrite_rule,
      rewrite_rule_set[337].rewrite_rule,
      rewrite_rule_set[338].rewrite_rule,
      rewrite_rule_set[339].rewrite_rule,
      rewrite_rule_set[340].rewrite_rule,
      rewrite_rule_set[341].rewrite_rule,
      rewrite_rule_set[342].rewrite_rule,
      rewrite_rule_set[343].rewrite_rule,
      rewrite_rule_set[344].rewrite_rule,
      rewrite_rule_set[345].rewrite_rule,
      rewrite_rule_set[346].rewrite_rule,
      rewrite_rule_set[347].rewrite_rule,
      rewrite_rule_set[348].rewrite_rule,
      rewrite_rule_set[349].rewrite_rule,
      rewrite_rule_set[350].rewrite_rule,
      rewrite_rule_set[351].rewrite_rule,
      rewrite_rule_set[352].rewrite_rule,
      rewrite_rule_set[353].rewrite_rule,
      rewrite_rule_set[354].rewrite_rule,
      rewrite_rule_set[355].rewrite_rule,
      rewrite_rule_set[356].rewrite_rule,
      rewrite_rule_set[357].rewrite_rule,
      rewrite_rule_set[358].rewrite_rule,
      rewrite_rule_set[359].rewrite_rule,
      rewrite_rule_set[360].rewrite_rule,
      rewrite_rule_set[361].rewrite_rule,
      rewrite_rule_set[362].rewrite_rule,
      rewrite_rule_set[363].rewrite_rule,
      rewrite_rule_set[364].rewrite_rule,
      rewrite_rule_set[365].rewrite_rule,
      rewrite_rule_set[366].rewrite_rule,
      rewrite_rule_set[367].rewrite_rule,
      rewrite_rule_set[368].rewrite_rule,
      rewrite_rule_set[369].rewrite_rule,
      rewrite_rule_set[370].rewrite_rule,
      rewrite_rule_set[371].rewrite_rule,
      rewrite_rule_set[372].rewrite_rule,
      rewrite_rule_set[373].rewrite_rule,
      rewrite_rule_set[374].rewrite_rule,
      rewrite_rule_set[375].rewrite_rule,
      rewrite_rule_set[376].rewrite_rule,
      rewrite_rule_set[377].rewrite_rule,
      rewrite_rule_set[378].rewrite_rule,
      rewrite_rule_set[379].rewrite_rule,
      rewrite_rule_set[380].rewrite_rule,
      rewrite_rule_set[381].rewrite_rule,
      rewrite_rule_set[382].rewrite_rule,
      rewrite_rule_set[383].rewrite_rule,
      rewrite_rule_set[384].rewrite_rule,
      rewrite_rule_set[385].rewrite_rule,
      rewrite_rule_set[386].rewrite_rule,
      rewrite_rule_set[387].rewrite_rule,
      rewrite_rule_set[388].rewrite_rule,
      rewrite_rule_set[389].rewrite_rule,
      rewrite_rule_set[390].rewrite_rule,
      rewrite_rule_set[391].rewrite_rule,
      rewrite_rule_set[392].rewrite_rule,
      rewrite_rule_set[393].rewrite_rule,
      rewrite_rule_set[394].rewrite_rule,
      rewrite_rule_set[395].rewrite_rule,
      rewrite_rule_set[396].rewrite_rule,
      rewrite_rule_set[397].rewrite_rule,
      rewrite_rule_set[398].rewrite_rule,
      rewrite_rule_set[399].rewrite_rule,
      rewrite_rule_set[400].rewrite_rule,
      rewrite_rule_set[401].rewrite_rule,
      rewrite_rule_set[402].rewrite_rule,
      rewrite_rule_set[403].rewrite_rule,
      rewrite_rule_set[404].rewrite_rule,
      rewrite_rule_set[405].rewrite_rule,
      rewrite_rule_set[406].rewrite_rule,
      rewrite_rule_set[407].rewrite_rule,
      rewrite_rule_set[408].rewrite_rule,
      rewrite_rule_set[409].rewrite_rule,
      rewrite_rule_set[410].rewrite_rule,
      rewrite_rule_set[411].rewrite_rule,
      rewrite_rule_set[412].rewrite_rule,
      rewrite_rule_set[413].rewrite_rule,
      rewrite_rule_set[414].rewrite_rule,
      rewrite_rule_set[415].rewrite_rule,
      rewrite_rule_set[416].rewrite_rule,
      rewrite_rule_set[417].rewrite_rule,
      rewrite_rule_set[418].rewrite_rule,
      rewrite_rule_set[419].rewrite_rule,
      rewrite_rule_set[420].rewrite_rule,
      rewrite_rule_set[421].rewrite_rule,
      rewrite_rule_set[422].rewrite_rule,
      rewrite_rule_set[423].rewrite_rule,
      rewrite_rule_set[424].rewrite_rule,
      rewrite_rule_set[425].rewrite_rule,
      rewrite_rule_set[426].rewrite_rule,
      rewrite_rule_set[427].rewrite_rule,
      rewrite_rule_set[428].rewrite_rule,
      rewrite_rule_set[429].rewrite_rule,
      rewrite_rule_set[430].rewrite_rule,
      rewrite_rule_set[431].rewrite_rule,
      rewrite_rule_set[432].rewrite_rule,
      rewrite_rule_set[433].rewrite_rule,
      rewrite_rule_set[434].rewrite_rule,
      rewrite_rule_set[435].rewrite_rule,
      rewrite_rule_set[436].rewrite_rule,
      rewrite_rule_set[437].rewrite_rule,
      rewrite_rule_set[438].rewrite_rule,
      rewrite_rule_set[439].rewrite_rule,
      rewrite_rule_set[440].rewrite_rule,
      rewrite_rule_set[441].rewrite_rule,
      rewrite_rule_set[442].rewrite_rule,
      rewrite_rule_set[443].rewrite_rule,
      rewrite_rule_set[444].rewrite_rule,
      rewrite_rule_set[445].rewrite_rule,
      rewrite_rule_set[446].rewrite_rule,
      rewrite_rule_set[447].rewrite_rule,
      rewrite_rule_set[448].rewrite_rule,
      rewrite_rule_set[449].rewrite_rule,
      rewrite_rule_set[450].rewrite_rule,
      rewrite_rule_set[451].rewrite_rule,
      rewrite_rule_set[452].rewrite_rule,
      rewrite_rule_set[453].rewrite_rule,
      rewrite_rule_set[454].rewrite_rule,
      rewrite_rule_set[455].rewrite_rule,
      rewrite_rule_set[456].rewrite_rule,
      rewrite_rule_set[457].rewrite_rule,
      rewrite_rule_set[458].rewrite_rule,
      rewrite_rule_set[459].rewrite_rule,
      rewrite_rule_set[460].rewrite_rule,
      rewrite_rule_set[461].rewrite_rule,
      rewrite_rule_set[462].rewrite_rule,
      rewrite_rule_set[463].rewrite_rule,
      rewrite_rule_set[464].rewrite_rule,
      rewrite_rule_set[465].rewrite_rule,
      rewrite_rule_set[466].rewrite_rule,
      rewrite_rule_set[467].rewrite_rule,
      rewrite_rule_set[468].rewrite_rule,
      rewrite_rule_set[469].rewrite_rule,
      rewrite_rule_set[470].rewrite_rule,
      rewrite_rule_set[471].rewrite_rule,
      rewrite_rule_set[472].rewrite_rule,
      rewrite_rule_set[473].rewrite_rule,
      rewrite_rule_set[474].rewrite_rule,
      rewrite_rule_set[475].rewrite_rule,
      rewrite_rule_set[476].rewrite_rule,
      rewrite_rule_set[477].rewrite_rule,
      rewrite_rule_set[478].rewrite_rule,
      rewrite_rule_set[479].rewrite_rule,
      rewrite_rule_set[480].rewrite_rule,
      rewrite_rule_set[481].rewrite_rule,
      rewrite_rule_set[482].rewrite_rule,
      rewrite_rule_set[483].rewrite_rule,
      rewrite_rule_set[484].rewrite_rule,
      rewrite_rule_set[485].rewrite_rule,
      rewrite_rule_set[486].rewrite_rule,
      rewrite_rule_set[487].rewrite_rule,
      rewrite_rule_set[488].rewrite_rule,
      rewrite_rule_set[489].rewrite_rule,
      rewrite_rule_set[490].rewrite_rule,
      rewrite_rule_set[491].rewrite_rule,
      rewrite_rule_set[492].rewrite_rule,
      rewrite_rule_set[493].rewrite_rule,
      rewrite_rule_set[494].rewrite_rule,
      rewrite_rule_set[495].rewrite_rule,
      rewrite_rule_set[496].rewrite_rule,
      rewrite_rule_set[497].rewrite_rule,
      rewrite_rule_set[498].rewrite_rule,
      rewrite_rule_set[499].rewrite_rule,
    ]

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
