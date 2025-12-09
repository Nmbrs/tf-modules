data "azurerm_mssql_server" "sql_server" {
  name                = replace(var.sql_server_settings.name, ".database.windows.net", "")
  resource_group_name = var.sql_server_settings.resource_group_name
}

data "azurerm_mssql_elasticpool" "sql_elasticpool" {
  count               = var.elastic_pool_settings != null ? 1 : 0
  name                = var.elastic_pool_settings.name
  resource_group_name = var.sql_server_settings.resource_group_name
  server_name         = replace(var.sql_server_settings.name, ".database.windows.net", "")
}
