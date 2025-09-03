locals {
  sql_server_name = (
    var.override_name != null && var.override_name != "" ?
    lower(var.override_name) :
    lower("sqls-${var.company_prefix}-${var.workload}-${var.environment}-${format("%03d", var.sequence_number)}")
  )

  audit_enabled = var.environment == "prod" || var.environment == "sand"
}
