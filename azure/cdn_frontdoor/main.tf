resource "azurerm_cdn_frontdoor_profile" "profile" {
  name                     = local.frontdoor_profile_name
  resource_group_name      = var.resource_group_name
  response_timeout_seconds = var.response_timeout_seconds
  sku_name                 = local.sku_name[var.sku_name]

  lifecycle {
    ignore_changes = [tags]
  }
}

resource "azurerm_cdn_frontdoor_endpoint" "endpoint" {
  for_each                 = { for endpoint in var.endpoints : lower(endpoint.name) => endpoint }
  name                     = "fde-${each.value.name}-${var.environment}"
  enabled                  = true
  cdn_frontdoor_profile_id = azurerm_cdn_frontdoor_profile.profile.id

  lifecycle {
    ignore_changes = [tags]
  }
}

resource "azurerm_cdn_frontdoor_origin_group" "group" {
  for_each                 = { for endpoint in var.endpoints : lower(endpoint.name) => endpoint }
  name                     = "fdog-${each.value.name}-${var.environment}"
  cdn_frontdoor_profile_id = azurerm_cdn_frontdoor_profile.profile.id
  session_affinity_enabled = each.value.origin_settings.session_affinity_enabled

  restore_traffic_time_to_healed_or_new_endpoint_in_minutes = 10

  health_probe {
    interval_in_seconds = 30
    path                = each.value.origin_settings.path
    protocol            = "Https"
    request_type        = "HEAD" #Do not change this as it might reduce the traffic load on the origin
  }

  load_balancing {
    additional_latency_in_milliseconds = 50
    sample_size                        = 4
    successful_samples_required        = 3
  }
}

resource "azurerm_cdn_frontdoor_origin" "origin" {
  for_each                       = { for origin in local.origins : "${lower(origin.fqdn)}-${origin.associated_endpoint_name}" => origin }
  name                           = replace(replace(each.value.fqdn, ".", "-"), "\\.$", "")
  cdn_frontdoor_origin_group_id  = azurerm_cdn_frontdoor_origin_group.group[lower(each.value.associated_endpoint_name)].id
  enabled                        = true
  certificate_name_check_enabled = false
  host_name                      = each.value.fqdn
  http_port                      = 80
  https_port                     = 443
  origin_host_header             = each.value.fqdn
  # Calculate priority (incremental based on the order of the origin in the list)
  priority = index(local.origins, each.value) + 1
}

resource "azurerm_cdn_frontdoor_rule_set" "rule_set" {
  for_each                 = { for endpoint in var.endpoints : lower(endpoint.name) => endpoint }
  name                     = each.value.name
  cdn_frontdoor_profile_id = azurerm_cdn_frontdoor_profile.profile.id
}

resource "azurerm_cdn_frontdoor_rule" "caching_rule" {
  for_each = {
    for endpoint in var.endpoints : lower(endpoint.name) => endpoint
    if endpoint.caching_rule_enabled
  }
  name                      = each.value.name
  cdn_frontdoor_rule_set_id = azurerm_cdn_frontdoor_rule_set.rule_set[lower(each.value.associated_endpoint_name)].id
  order                     = 1
  behavior_on_match         = "Continue"

  actions {
    response_header_action {
      header_action = "Delete"
      header_name   = "Age"
    }
    response_header_action {
      header_action = "Overwrite"
      header_name   = "Cache-Control"
      value         = "Max-Age=${60 * each.value.caching_timeout_minutes}"
    }
  }

  depends_on = [azurerm_cdn_frontdoor_origin_group.group, azurerm_cdn_frontdoor_origin.origin]
}


resource "azurerm_cdn_frontdoor_custom_domain" "domain" {
  for_each                 = { for domain in local.custom_domains : lower(domain.fqdn) => domain }
  name                     = replace(replace(each.key, ".", "-"), "\\.$", "")
  cdn_frontdoor_profile_id = azurerm_cdn_frontdoor_profile.profile.id
  dns_zone_id              = data.azurerm_dns_zone.dns_zone[each.key].id
  host_name                = each.key

  tls {
    certificate_type    = "ManagedCertificate"
    minimum_tls_version = "TLS12"
  }
}

resource "azurerm_dns_cname_record" "record" {
  for_each            = { for domain in local.custom_domains : lower(domain.fqdn) => domain }
  name                = each.value.fqdn
  zone_name           = each.value.dns_zone_name
  resource_group_name = each.value.dns_zone_resource_group_name
  ttl                 = 300
  record              = azurerm_cdn_frontdoor_endpoint.endpoint[each.value.associated_endpoint_name].host_name

  lifecycle {
    ignore_changes = [tags]
  }

  depends_on = [azurerm_cdn_frontdoor_route.route]
}

resource "azurerm_cdn_frontdoor_route" "route" {
  for_each                      = { for endpoint in var.endpoints : lower(endpoint.name) => endpoint }
  name                          = "fdr-${each.value.name}-${var.environment}"
  cdn_frontdoor_endpoint_id     = azurerm_cdn_frontdoor_endpoint.endpoint[each.key].id
  cdn_frontdoor_origin_group_id = azurerm_cdn_frontdoor_origin_group.group[each.key].id
  cdn_frontdoor_origin_ids = [
    for origin in azurerm_cdn_frontdoor_origin.origin :
    origin.cdn_frontdoor_origin_group_id == azurerm_cdn_frontdoor_origin_group.group[each.key].id ? origin.id : null
  ]
  cdn_frontdoor_rule_set_ids = [azurerm_cdn_frontdoor_rule_set.rule_set[each.key].id]
  enabled                    = true
  cdn_frontdoor_origin_path  = each.value.origin_settings.path
  forwarding_protocol        = "HttpsOnly"
  https_redirect_enabled     = true
  patterns_to_match          = each.value.origin_settings.patterns_to_match
  supported_protocols        = ["Http", "Https"]

  cdn_frontdoor_custom_domain_ids = [
    for domain in local.custom_domains :
    domain.associated_endpoint_name == each.key ? azurerm_cdn_frontdoor_custom_domain.domain[lower(domain.name)].id : null
  ]
  link_to_default_domain = false

  cache {
    query_string_caching_behavior = "IgnoreQueryString"
    compression_enabled           = false
    content_types_to_compress     = []
  }
}


