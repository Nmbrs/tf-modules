locals {
  sql_server_name = "sqls-${var.workload}-${var.environment}-${var.location}-${format("%03d", var.instance_count)}"
}