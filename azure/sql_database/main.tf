resource "azurerm_mssql_database" "sql_database" {
  name            = local.sql_database_name
  server_id       = data.azurerm_mssql_server.sql_server.id
  sku_name        = var.sku_name
  collation       = var.collation
  license_type    = var.license_type
  elastic_pool_id = var.sql_elastic_pool_name != "" ? data.azurerm_mssql_elasticpool.sql_elasticpool.id : null

  short_term_retention_policy {
    retention_days           = local.backup_settings.pitr_backup_retention_days
    backup_interval_in_hours = local.backup_settings.diff_backup_frequency_hours
  }

  long_term_retention_policy {
    weekly_retention  = "P${local.backup_settings.weekly_ltr_retention_months}M"
    monthly_retention = "P${local.backup_settings.monthly_ltr_retention_years}Y"
    yearly_retention  = "P${local.backup_settings.yearly_ltr_retention_years}Y"
    week_of_year      = local.backup_settings.yearly_ltr_week_number
  }

  lifecycle {
    ignore_changes = [tags]
  }
}