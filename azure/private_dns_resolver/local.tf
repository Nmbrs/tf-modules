locals {
  dns_resolver_name = "dnspr-${var.workload}-${var.environment}-${var.location}-${format("%03d", var.naming_count)}"
}
