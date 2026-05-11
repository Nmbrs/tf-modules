output "name" {
  value = azurerm_mssql_database.main.name
}

output "workload" {
  value = var.workload
}

output "id" {
  value = azurerm_mssql_database.main.id
}

output "collation" {
  value = azurerm_mssql_database.main.collation
}
