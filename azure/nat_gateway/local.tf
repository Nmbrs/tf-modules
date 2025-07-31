locals {
  # NAT Gateway name: Must be unique within subscription
  # Format: ng-{company}-{workload}-{env}-{location}-{seq}
  nat_gateway_name = (var.override_name != null ?
    lower(var.override_name) :
    lower("ng-${var.company_prefix}-${var.workload}-${var.environment}-${var.location}-${format("%03d", var.sequence_number)}")
  )

  # Public IP name follows the NAT gateway naming pattern with pip prefix
  public_ip_name = "pip-${local.nat_gateway_name}"
}
