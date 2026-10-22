resource "azurerm_app_configuration" "main" {
  name                     = local.name
  resource_group_name      = var.resource_group_name
  location                 = var.location
  sku                      = var.sku_name
  public_network_access    = var.public_network_access_enabled ? "Enabled" : "Disabled"
  local_auth_enabled       = false
  purge_protection_enabled = contains(["standard", "premium"], lower(var.sku_name))

  lifecycle {
    ignore_changes = [tags]

    precondition {
      condition = var.override_name != null || (
        var.workload != null &&
        var.company_prefix != null
      )
      error_message = "Invalid naming configuration: Either 'override_name' must be provided, or both 'workload' and 'company_prefix' must be provided for automatic naming."
    }

    precondition {
      condition     = !contains(["standard", "premium"], lower(var.sku_name)) || var.private_endpoint_settings != null
      error_message = "Invalid configuration: 'private_endpoint_settings' must be provided when 'sku_name' is 'standard' or 'premium'."
    }

    precondition {
      condition     = contains(["standard", "premium"], lower(var.sku_name)) || var.private_endpoint_settings == null
      error_message = format("Invalid configuration: 'private_endpoint_settings' must be null when 'sku_name' is '%s'. Private endpoints are only supported on the 'standard' or 'premium' tier.", var.sku_name)
    }
  }
}
