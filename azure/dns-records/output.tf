# output "instrumentation_key" {
#   value = azurerm_application_insights.app.instrumentation_key
# }

# output "app_id" {
#   value = azurerm_application_insights.app.app_id
# }

# output "custom_domain" {
#   value= {for k, domain in azurerm_app_service_custom_hostname_binding.custom_domain : k => domain.hostname}
# }

# output "dns_zone_id" {
#   value = data.azurerm_dns_zone.binding
# }

# output "custom_domain_verification_id" {
#   value = data.azurerm_app_service.binding.custom_domain_verification_id
  
# }

# output "certificate_thumbprint" {
#   value = data.azurerm_key_vault_certificate.binding.thumbprint
# }
