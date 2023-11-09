locals {
  app_gateway_name = "agw-${var.workload}-${var.environment}-${var.location}-${format("%03d", var.instance_count)}"

  public_ip_name = "pip-agw-${var.workload}-${var.environment}-${var.location}-${format("%03d", var.instance_count)}"
}
