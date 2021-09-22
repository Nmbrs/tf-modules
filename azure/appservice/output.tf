output "instrumentation_key" {
  value = azurerm_application_insights.apm.instrumentation_key
}

output "app_id" {
  value = azurerm_application_insights.app.app_id
}