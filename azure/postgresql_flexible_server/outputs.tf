output "name" {
  description = "The name of the PostgreSQL Flexible Server."
  value       = azurerm_postgresql_flexible_server.main.name
}

output "workload" {
  description = "The PostgreSQL Flexible Server workload."
  value       = var.workload
}

output "id" {
  description = "The PostgreSQL Flexible Server ID."
  value       = azurerm_postgresql_flexible_server.main.id
}

output "fqdn" {
  description = "The fully qualified domain name of the PostgreSQL Flexible Server."
  value       = azurerm_postgresql_flexible_server.main.fqdn
}
