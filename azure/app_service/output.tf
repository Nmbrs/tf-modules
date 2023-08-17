output "instrumentation_key" {
  value = azurerm_application_insights.service_plan.instrumentation_key
}

output "app_id" {
  value = azurerm_application_insights.service_plan.app_id
}