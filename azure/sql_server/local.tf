locals {
  sql_server_name = (
    var.override_name != null ?
    lower(var.override_name) :
    lower("sqls-${var.company_prefix}-${var.workload}-${var.environment}-${var.location}-${format("%03d", var.sequence_number)}")
  )

  auditing_enabled = var.auditing_settings != null

  private_endpoint_subresources = ["sqlServer"]
}
