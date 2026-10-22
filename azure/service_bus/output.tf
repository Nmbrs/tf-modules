output "name" {
  value       = azurerm_servicebus_namespace.main.name
  description = "The servicebus namespace name."
}

output "workload" {
  description = "The servicebus namespace workload name."
  value       = var.workload
}

output "id" {
  value       = azurerm_servicebus_namespace.main.id
  description = "The servicebus namespace ID."
}

output "default_connection_string" {
  description = "The primary connection string for the authorization rule RootManageSharedAccessKey which is created automatically by Azure."
  value       = azurerm_servicebus_namespace.main.default_primary_connection_string
}
