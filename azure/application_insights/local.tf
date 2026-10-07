locals {
  # Format: appi-{workload}-{env}
  # Example: appi-contoso-prod
  app_insights_name = (var.override_name != null ?
    lower(var.override_name) :
    lower("appi-${var.workload}-${var.environment}")
  )
}
