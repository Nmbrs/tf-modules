locals {
  nat_gateway_name = "ng-${var.name}-${var.environment}-${var.location}-${format("%03d", var.instance_count)}"

  public_ip_name = "pip-ng-${var.name}-${var.environment}-${var.location}-${format("%03d", var.instance_count)}"
}
