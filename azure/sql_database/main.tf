resource "azurerm_mssql_database" "main" {
  name            = local.sql_database_name
  server_id       = data.azurerm_mssql_server.sql_server.id
  sku_name        = var.elastic_pool_settings != null ? null : var.sku_name
  collation       = var.collation
  license_type    = var.license_type
  elastic_pool_id = var.elastic_pool_settings != null ? data.azurerm_mssql_elasticpool.sql_elasticpool[0].id : null
  max_size_gb     = var.elastic_pool_settings != null ? 1024 : var.max_size_gb

  short_term_retention_policy {
    retention_days           = local.backup_settings.pitr_backup_retention_days
    backup_interval_in_hours = local.backup_settings.diff_backup_frequency_hours
  }

  dynamic "long_term_retention_policy" {
    for_each = local.long_term_retention_policy_enabled ? [1] : []
    content {
      weekly_retention  = "P${local.backup_settings.weekly_ltr_retention_months}M"
      monthly_retention = "P${local.backup_settings.monthly_ltr_retention_years}Y"
      yearly_retention  = "P${local.backup_settings.yearly_ltr_retention_years}Y"
      week_of_year      = local.backup_settings.yearly_ltr_week_number
    }
  }

  lifecycle {
    ignore_changes = [tags]

    ## Naming validation: Ensure either override_name is provided OR all naming components are provided
    precondition {
      condition = var.override_name != null || (
        var.workload != null &&
        var.company_prefix != null &&
        var.sequence_number != null
      )
      error_message = "Invalid naming configuration: Either 'override_name' must be provided, or all of 'workload', 'company_prefix', and 'sequence_number' must be provided for automatic naming."
    }
  }
}
