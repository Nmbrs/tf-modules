resource "azurerm_mssql_database" "sql_database" {
  name            = local.sql_database_name
  server_id       = data.azurerm_mssql_server.sql_server.id
  sku_name        = var.sku_name
  collation       = var.collation
  license_type    = var.license_type
  elastic_pool_id = var.sql_elastic_pool_name != "" ? data.azurerm_mssql_elasticpool.sql_elasticpool.id : null

  lifecycle {
    ignore_changes = [tags]
  }
}