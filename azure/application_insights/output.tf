output "name" {
  value       = azurerm_application_insights.insights.name
  description = "The Application Insight component name."
}

output "workload" {
  description = "The Application Insights workload name."
  value       = var.workload
}

output "id" {
  value       = azurerm_application_insights.insights.app_id
  description = "The ID of the Application Insights component."
}

output "app_id" {
  value       = azurerm_application_insights.insights.app_id
  description = "The App ID associated with this Application Insights component."
}

output "instrumentation_key" {
  description = "The Instrumentation Key for this Application Insights component."
  value       = azurerm_application_insights.insights.instrumentation_key
  sensitive   = true
}

output "connection_string" {
  description = "The Connection String for this Application Insights component."
  value       = azurerm_application_insights.insights.connection_string
  sensitive   = true
}

