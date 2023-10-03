locals {
  dns_resolver_name = "dnspr-${var.name}-${var.environment}-${var.location}-${format("%03d", var.name_sequence_number)}"
}
