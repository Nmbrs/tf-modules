locals {
  service_bus_name = (
    var.override_name != null && var.override_name != "" ?
    lower(var.override_name) :
    lower("sb-${var.company_prefix}-${var.workload}-${var.environment}")
  )

  private_endpoint_subresources = ["namespace"]
}
