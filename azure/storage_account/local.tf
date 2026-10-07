locals {
  storage_account_name = (
    var.override_name != null && var.override_name != "" ?
    lower(var.override_name) :
    lower("sa${var.company_prefix}${var.workload}${var.environment}")
  )
}
