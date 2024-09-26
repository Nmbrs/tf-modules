locals {
  cosmo_db_name = "cosmos-${var.workload}-${var.environment}-${var.location}-${format("%03d", var.instance_count)}"
}
