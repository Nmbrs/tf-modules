output "name" {
  description = "The name of the PostgreSQL Flexible Server."
  value       = azurerm_postgresql_flexible_server.main.name
}

output "workload" {
  description = "The PostgreSQL Flexible Server workload name."
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

output "administrator_login" {
  description = "The local administrator login of the PostgreSQL Flexible Server, or null when Entra ID is the only authentication method."
  value       = local.local_admin_enabled ? azurerm_postgresql_flexible_server.main.administrator_login : null
}
