locals {
  # SQL Database naming pattern: sqldb-{workload}-{env}-{location}-{seq}
  # Example: sqldb-analytics-prod-westeurope-001
  sql_database_name = (
    var.override_name != null ?
    lower(var.override_name) :
    lower("sqldb-${var.workload}-${var.environment}-${var.location}-${format("%03d", var.sequence_number)}")
  )

  long_term_retention_policy_enabled = var.environment == "prod"

  backup_settings = {
    pitr_backup_retention_days  = 14
    diff_backup_frequency_hours = 12
    weekly_ltr_retention        = "P1M" # keep weekly backups for 1 month
    monthly_ltr_retention       = "P1Y" # keep monthly backups for 1 year
    yearly_ltr_retention        = "P7Y" # keep yearly backups for 7 years
    yearly_ltr_week_number      = 1
  }
}
