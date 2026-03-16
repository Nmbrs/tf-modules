locals {
  # Format: appcs-{company}-{workload}-{env}
  name = (var.override_name != null ?
    lower(var.override_name) :
    lower("appcs-${var.company_prefix}-${var.workload}-${var.environment}")
  )
}
