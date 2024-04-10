locals {
  service_bus_name = lower("sb-nmbrs-${var.workload}-${var.environment}")
}
