resource "azurerm_container_registry" "main" {
  name                          = local.container_registry_name
  resource_group_name           = var.resource_group_name
  location                      = var.location
  sku                           = var.sku_name
  admin_enabled                 = false
  public_network_access_enabled = var.firewall_settings.public_network_access_enabled
  network_rule_bypass_option    = local.network_rule_bypass

  dynamic "network_rule_set" {
    for_each = var.sku_name == "Premium" ? [1] : []
    content {
      default_action = "Deny"
    }
  }


  lifecycle {
    ignore_changes = [tags]

    ## Naming validation: Ensure either override_name is provided OR all naming components are provided
    precondition {
      condition = var.override_name != null || (
        var.workload != null &&
        var.company_prefix != null
      )
      error_message = "Invalid naming configuration: Either 'override_name' must be provided, or both 'workload' and 'company_prefix' must be provided for automatic naming."
    }

    ## SKU validation for public network access
    precondition {
      condition     = var.sku_name == "Premium" || var.firewall_settings.public_network_access_enabled == true
      error_message = "Invalid configuration: 'firewall_settings.public_network_access_enabled' can only be set to false when 'sku_name' is 'Premium'. For 'Basic' and 'Standard' SKUs, public network access is always enabled."
    }

    ## Trusted services bypass is only meaningful on Premium in private mode (public access disabled).
    ## Network rules are Premium-only, and bypass has nothing to bypass when public access is enabled.
    precondition {
      condition = var.firewall_settings.trusted_services_bypass_firewall_enabled == false || (
        var.sku_name == "Premium" && var.firewall_settings.public_network_access_enabled == false
      )
      error_message = "Invalid configuration: 'firewall_settings.trusted_services_bypass_firewall_enabled' can only be true when sku_name = 'Premium' AND firewall_settings.public_network_access_enabled = false (private mode). On public registries there is nothing to bypass."
    }
  }
}
