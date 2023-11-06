locals {
  dns_resolver_name = "dnspr-${var.name}-${var.environment}-${var.location}-${format("%03d", var.instance_count)}"
}
