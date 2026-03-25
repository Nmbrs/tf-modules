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
  }
}
