locals {
  # Naming pattern: cr{company_prefix}{workload}{environment}, e.g. crnmbrscontosoprod.
  # ACR names are globally unique, alphanumeric-only, 5-50 chars (no separators allowed).
  container_registry_name = (var.override_name != null ?
    lower(var.override_name) :
    lower("cr${var.company_prefix}${var.workload}${var.environment}")
  )

  network_rule_bypass = var.trusted_services_bypass_firewall_enabled ? "AzureServices" : "None"
}
