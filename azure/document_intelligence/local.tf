locals {
  document_intelligence = "di-${var.workload}-${var.environment}-${var.location}-${format("%03d", var.instance_count)}"
}
