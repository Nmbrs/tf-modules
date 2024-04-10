data "azurerm_mssql_server" "sql_server" {
  name                = replace(var.sql_server_name, ".database.windows.net", "")
  resource_group_name = var.sql_server_resource_group_name
}

data "azurerm_mssql_elasticpool" "sql_elasticpool" {
  name                = var.sql_elastic_pool_name
  resource_group_name = var.sql_server_resource_group_name
  server_name         = replace(var.sql_server_name, ".database.windows.net", "")
}