output "name" {
  description = "The SQL Server full name."
  value       = azurerm_mssql_server.main.name
}

output "workload" {
  description = "The SQL Server workload."
  value       = var.workload
}

output "id" {
  description = "The SQL Server ID."
  value       = azurerm_mssql_server.main.id
}

output "fqdn" {
  description = "The fully qualified domain name of the SQL Server."
  value       = azurerm_mssql_server.main.fully_qualified_domain_name
}
