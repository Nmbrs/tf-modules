locals {
  sql_database_name = "sqldb-${var.workload}-${var.environment}-${var.location}-${format("%03d", var.instance_count)}"
  long_term_retention_policy_enabled = var.environment == "prod"
  backup_settings = {
    pitr_backup_retention_days  = 14
    diff_backup_frequency_hours = 12
    weekly_ltr_retention_months = 1
    monthly_ltr_retention_years = 1
    yearly_ltr_retention_years  = 7
    yearly_ltr_week_number      = 1
  }
}
