locals {
  sql_server_name = (
    var.override_name != null ?
    lower(var.override_name) :
    lower("sqls-${var.company_prefix}-${var.workload}-${var.environment}-${var.location}-${format("%03d", var.sequence_number)}")
  )

  # Define which environments require auditing (single source of truth)
  audited_environments = ["prod", "sand", "stage"]

  # Compute whether auditing is enabled for the current environment
  audit_enabled = contains(local.audited_environments, var.environment)
}
