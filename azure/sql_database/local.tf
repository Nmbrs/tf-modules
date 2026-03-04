locals {
  # SQL Database naming pattern: sqldb-{company}-{workload}-{env}-{location}-{seq}
  # Example: sqldb-nmbrs-analytics-prod-westeurope-001
  sql_database_name = (
    var.override_name != null ?
    lower(var.override_name) :
    lower("sqldb-${var.company_prefix}-${var.workload}-${var.environment}-${var.location}-${format("%03d", var.sequence_number)}")
  )

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
