locals {
  # Container Registry naming pattern: cr{company}{workload}{env}
  # Example: crnmbrscontosoprod
  # Note: No dashes allowed in container registry names (Azure restriction)
  # No sequence_number - relies on company_prefix + workload + env for uniqueness
  container_registry_name = (var.override_name != null ?
    lower(var.override_name) :
    lower("cr${var.company_prefix}${var.workload}${var.environment}")
  )

  # Network rule bypass option depends on SKU
  # Premium SKU: Can use "AzureServices" or "None"
  # Basic/Standard SKU: Must be "None"
  network_rule_bypass = var.sku_name == "Premium" && var.trusted_services_bypass_firewall_enabled ? "AzureServices" : "None"

  # Public network access is only applicable for Premium SKU
  # For Basic/Standard, it must be enabled (cannot be disabled)
  public_network_access = var.sku_name == "Premium" ? var.public_network_access_enabled : true
}
