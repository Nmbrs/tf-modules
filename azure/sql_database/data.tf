data "azurerm_mssql_server" "sql_server" {
  name                = replace(var.sql_server_settings.name, ".database.windows.net", "")
  resource_group_name = var.sql_server_settings.resource_group_name
}

data "azurerm_mssql_elasticpool" "sql_elasticpool" {
  count               = var.sql_elastic_pool_name != "" && var.sql_elastic_pool_name != null ? 1 : 0
  name                = var.sql_elastic_pool_name
  resource_group_name = var.sql_server_settings.resource_group_name
  server_name         = replace(var.sql_server_settings.name, ".database.windows.net", "")
}