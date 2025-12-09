output "sql_database_name" {
  value = azurerm_mssql_database.main.name
}

output "sql_database_id" {
  value = azurerm_mssql_database.main.id
}

output "sql_database_collation" {
  value = azurerm_mssql_database.main.collation
}