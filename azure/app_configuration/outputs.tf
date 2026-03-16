output "name" {
  description = "The App Configuration full name."
  value       = azurerm_app_configuration.main.name
}

output "workload" {
  description = "The App Configuration workload."
  value       = var.workload
}

output "id" {
  description = "The App Configuration ID."
  value       = azurerm_app_configuration.main.id
}

output "endpoint" {
  description = "The endpoint used to access the App Configuration."
  value       = azurerm_app_configuration.main.endpoint
}
