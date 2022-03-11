output "instrumentation_key" {
  value = azurerm_application_insights.app.instrumentation_key
}

output "app_id" {
  value = azurerm_application_insights.app.app_id
}

# output "custom_domain" {
#   value= {for k, domain in azurerm_app_service_custom_hostname_binding.custom_domain : k => domain.hostname}
# }

output "name" {
  value = {for k, app in azurerm_app_service.app : k => app.name}
}