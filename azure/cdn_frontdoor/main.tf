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
    interval_in_seconds = each.value.origin_settings.health_probe.evaluation_interval_in_seconds
    path                = each.value.origin_settings.health_probe.path
    protocol            = title(each.value.origin_settings.health_probe.protocol)
    request_type        = "HEAD" #Do not change this as it might reduce the traffic load on the origin
  }

  load_balancing {
    additional_latency_in_milliseconds = 50
    sample_size                        = 4
    successful_samples_required        = 1
  }
}


resource "azurerm_cdn_frontdoor_origin" "origin" {
  for_each                       = { for origin in local.origins : "${lower(origin.fqdn)}-${origin.endpoint_name}" => origin }
  name                           = replace(replace(each.value.fqdn, ".", "-"), "\\.$", "") # replaces . with - and remove trailing dots
  cdn_frontdoor_origin_group_id  = azurerm_cdn_frontdoor_origin_group.group[lower(each.value.endpoint_name)].id
  enabled                        = true
  certificate_name_check_enabled = false
  host_name                      = each.value.fqdn
  http_port                      = each.value.http_port
  https_port                     = each.value.https_port
  origin_host_header             = each.value.fqdn
  # Calculate priority (incremental based on the order of the origin in the list)
  priority = index(local.origins, each.value) + 1
  weight   = 1
}
