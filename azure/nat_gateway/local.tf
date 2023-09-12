locals {
  nat_gateway_name = "ng-${var.name}-${var.environment}-${var.location}-${format("%03d", var.name_sequence_number)}"

  public_ip_name = "pip-${var.name}-${var.environment}-${var.location}-${format("%03d", var.name_sequence_number)}"
}
