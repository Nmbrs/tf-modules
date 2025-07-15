locals {
  name = (
    var.override_name != null && trimspace(var.override_name) != "" ?
    lower(var.override_name) :
    lower("appcs-${var.company_prefix}-${var.workload}-${var.environment}")
  )
}
