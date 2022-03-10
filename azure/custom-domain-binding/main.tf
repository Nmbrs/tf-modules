# data "azurerm_dns_zone" "binding" {
#   name                = "nmbrs-dev009.com"
#   resource_group_name = "rg-dnszones"
# }

# resource "azurerm_dns_cname_record" "binding" {
#   #for_each = var.apps
#   name                = "*"
#   zone_name           = data.azurerm_dns_zone.binding.name
#   resource_group_name = data.azurerm_dns_zone.binding.resource_group_name
#   ttl                 = 300
#   record              = "as-mobile-mobile-kitchen.azurewebsites.net"
# }

# data "azurerm_app_service" "binding" {
#   name = "as-mobile-mobile-kitchen"
#   resource_group_name = "rg-mobile-kitchen"
# }

# resource "azurerm_dns_txt_record" "binding" {
#   name                = "asuid.${azurerm_dns_cname_record.binding.name}"
#   zone_name           = data.azurerm_dns_zone.binding.name
#   resource_group_name = data.azurerm_dns_zone.binding.resource_group_name
#   ttl                 = 300
#   record {
#     value = data.azurerm_app_service.binding.custom_domain_verification_id
#   }
# }

# resource "azurerm_app_service_custom_hostname_binding" "binding" {
#   hostname            = trim(azurerm_dns_cname_record.binding.fqdn, ".")
#   app_service_name    = data.azurerm_app_service.binding.name
#   resource_group_name = "rg-mobile-kitchen"
#   depends_on          = [azurerm_dns_txt_record.binding]

#   # Ignore ssl_state and thumbprint as they are managed using
#   # azurerm_app_service_certificate_binding.example
#   lifecycle {
#     ignore_changes = [ssl_state, thumbprint]
#   }
# }

# resource "azurerm_app_service_managed_certificate" "binding" {
#   custom_hostname_binding_id = azurerm_app_service_custom_hostname_binding.binding.id
# }

# resource "azurerm_app_service_certificate_binding" "binding" {
#   hostname_binding_id = azurerm_app_service_custom_hostname_binding.binding.id
#   certificate_id      = azurerm_app_service_managed_certificate.binding.id
#   ssl_state           = "SniEnabled"
# }


