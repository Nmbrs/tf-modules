locals {
#container_app_environment_name = lower("cae-${var.workload}-${var.environment}-${var.location}-${format("%03d", var.naming_count)}")
container_app_environment_name = lower("cae-${var.workload}-${format("%03d", var.naming_count)}-${var.environment}")
#container_app_environment_name = lower("cae-${var.workload}-${var.environment}")
}
