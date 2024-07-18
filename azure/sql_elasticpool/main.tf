resource "azurerm_mssql_elasticpool" "elasticpool" {
  license_type                   = "BasePrice"
  location                       = var.location
  maintenance_configuration_name = "SQL_WestEurope_DB_2"
  max_size_gb                    = var.max_size_gb
  name                           = "sqlep-monolith-n21-nl-prod"
  resource_group_name            = var.resource_group_name
  server_name                    = var.sql_server_name
  zone_redundant                 = false

  per_database_settings {
    # This setting prevents the database from occupying 100% of the elastic pool's capacity
    max_capacity = var.capacity <= 2 ? var.capacity : var.capacity - 2
    min_capacity = 0
  }

  sku {
    capacity = var.capacity
    family   = "Gen5"
    name     = "GP_Gen5"
    tier     = "GeneralPurpose"
  }
  lifecycle {
    ignore_changes = [tags]
  }
}
