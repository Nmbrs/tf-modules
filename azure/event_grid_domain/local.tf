locals {
  event_grid_domain_name = "evgd-${var.name}-${var.environment}-${var.location}-${format("%03d", var.instance_count)}"
}
