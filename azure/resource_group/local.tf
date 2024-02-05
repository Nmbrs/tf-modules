locals {
  resource_group_name = lower("rg-${var.workload}-${var.environment}")
}
