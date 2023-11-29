locals {
  storage_account_name = lower("sanmbrs${var.workload}${var.environment}")
}
