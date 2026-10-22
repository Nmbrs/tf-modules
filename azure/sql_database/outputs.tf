output "name" {
  description = "The name of the SQL database."
  value       = azurerm_mssql_database.main.name
}

output "workload" {
  description = "The SQL database workload name."
  value       = var.workload
}

output "id" {
  description = "The SQL database ID."
  value       = azurerm_mssql_database.main.id
}

output "collation" {
  description = "The collation of the SQL database."
  value       = azurerm_mssql_database.main.collation
}
