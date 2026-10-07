moved {
  from = azurerm_mssql_database.sql_database
  to   = azurerm_mssql_database.main
}

resource "azurerm_mssql_database" "main" {
  name            = local.sql_database_name
  server_id       = data.azurerm_mssql_server.sql_server.id
  sku_name        = var.elastic_pool_settings != null ? null : var.sku_name
  collation       = var.collation
  license_type    = var.elastic_pool_settings != null ? null : var.license_type
  elastic_pool_id = var.elastic_pool_settings != null ? data.azurerm_mssql_elasticpool.sql_elasticpool[0].id : null
  max_size_gb     = var.elastic_pool_settings != null ? 1024 : var.max_size_gb

  short_term_retention_policy {
    retention_days           = local.backup_settings.pitr_backup_retention_days
    backup_interval_in_hours = local.backup_settings.diff_backup_frequency_hours
  }

  dynamic "long_term_retention_policy" {
    for_each = local.long_term_retention_policy_enabled ? [1] : []
    content {
      weekly_retention  = local.backup_settings.weekly_ltr_retention
      monthly_retention = local.backup_settings.monthly_ltr_retention
      yearly_retention  = local.backup_settings.yearly_ltr_retention
      week_of_year      = local.backup_settings.yearly_ltr_week_number
    }
  }

  lifecycle {
    # sku_name and max_size_gb are operational (scaling) parameters: they only set the initial
    # values at creation and are expected to be changed out-of-band afterwards.
    ignore_changes = [tags, sku_name, max_size_gb]

    ## Naming validation: Ensure either override_name is provided OR the required naming components are provided
    precondition {
      condition     = var.override_name != null || var.workload != null
      error_message = "Invalid naming configuration: Either 'override_name' must be provided, or 'workload' must be provided for automatic naming."
    }
  }
}
