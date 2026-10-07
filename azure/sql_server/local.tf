locals {
  sequence_suffix = var.sequence_number == null ? "" : "-${format("%03d", var.sequence_number)}"

  sql_server_name = "sqls-${var.workload}-${var.environment}-${var.location}${local.sequence_suffix}"
  audit_enabled   = var.environment == "prod" || var.environment == "sand"
}
