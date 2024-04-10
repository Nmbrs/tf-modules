locals {
  sql_database_name = "sqldb-${var.sql_database_name}-${var.country}-${var.environment}"
  backup_settings = var.environment == "prod" ? {
    pitr_backup_retention_days  = 14
    diff_backup_frequency_hours = 12
    weekly_ltr_retention_months = 1
    monthly_ltr_retention_years = 1
    yearly_ltr_retention_years  = 7
    yearly_ltr_week_number      = 1
    } : {
    pitr_backup_retention_days  = 7
    diff_backup_frequency_hours = 24
    weekly_ltr_retention_months = 0
    monthly_ltr_retention_years = 0
    yearly_ltr_retention_years  = 0
    yearly_ltr_week_number      = 0
  }
}
