output "instrumentation_key" {
  value = azurerm_application_insights.app.instrumentation_key
}

output "app_id" {
  value = azurerm_application_insights.app.app_id
}

output "name" {
  value = {for k, app in azurerm_app_service.app : k => app.name}
}