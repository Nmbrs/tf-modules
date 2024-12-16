resource "azurerm_cdn_frontdoor_profile" "profile" {
  name                     = local.frontdoor_profile_name
  resource_group_name      = var.resource_group_name
  response_timeout_seconds = var.response_timeout_seconds
  sku_name                 = local.sku_name[var.sku_name]
}

resource "azurerm_cdn_frontdoor_endpoint" "endpoint" {
  
  for_each                 = { for endpoint in var.endpoints: lower(endpoint.name) => endpoint }
  name                     = "fde-${each.value.name}-${var.environment}"
  enabled                  = true
  cdn_frontdoor_profile_id = azurerm_cdn_frontdoor_profile.profile.id
}

# resource "azurerm_cdn_frontdoor_origin_group" "group" {
#   name                     = "example-origin-group"
#   cdn_frontdoor_profile_id = azurerm_cdn_frontdoor_profile.example.id
#   session_affinity_enabled = true

#   restore_traffic_time_to_healed_or_new_endpoint_in_minutes = 10

#   health_probe {
#     interval_in_seconds = 240
#     path                = "/healthProbe"
#     protocol            = "Https"
#     request_type        = "HEAD"
#   }

#   load_balancing {
#     additional_latency_in_milliseconds = 0
#     sample_size                        = 16
#     successful_samples_required        = 3
#   }
# }

# resource "azurerm_cdn_frontdoor_origin" "origin" {
#   name                          = "example-origin"
#   cdn_frontdoor_origin_group_id = azurerm_cdn_frontdoor_origin_group.example.id
#   enabled                       = true

#   certificate_name_check_enabled = false

#   host_name          = "contoso.com"
#   http_port          = 80
#   https_port         = 443
#   origin_host_header = "www.contoso.com"
#   priority           = 1
#   weight             = 1
# }