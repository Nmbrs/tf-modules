output "instrumentation_key" {
  value = azurerm_application_insights.app.instrumentation_key
}

output "app_id" {
  value = azurerm_application_insights.app.app_id
}

output "resource_group" {
  value = azurerm_resource_group.app.name
}

output "location" {
  value = azurerm_resource_group.app.location
}