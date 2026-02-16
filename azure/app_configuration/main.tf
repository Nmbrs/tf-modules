resource "azurerm_app_configuration" "app_configuration" {
  name                     = local.name
  resource_group_name      = var.resource_group_name
  location                 = var.location
  sku                      = var.sku_name
  public_network_access    = var.public_network_access_enabled ? "Enabled" : "Disabled"
  local_auth_enabled       = false
  purge_protection_enabled = contains(["standard", "premium"], lower(var.sku_name))

  lifecycle {
    ignore_changes = [tags]
  }
}
