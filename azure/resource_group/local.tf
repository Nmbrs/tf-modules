locals {
  # Resource Group name: Must be unique within subscription
  # Format: rg-{workload}-{env}
  resource_group_name = (var.override_name != null ?
    lower(var.override_name) :
    lower("rg-${var.workload}-${var.environment}")
  )
}
