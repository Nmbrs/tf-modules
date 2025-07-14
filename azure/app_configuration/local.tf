locals {
  name = var.override_name != "" && var.override_name != null ? var.override_name : lower("appcs-${var.company_prefix}-${var.workload}-${var.environment}")
}
