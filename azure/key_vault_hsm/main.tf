resource "azurerm_key_vault_managed_hardware_security_module" "main" {
  name                = local.key_vault_managed_hsm_name
  location            = var.location
  resource_group_name = var.resource_group_name
  tenant_id           = data.azurerm_client_config.current.tenant_id

  sku_name                   = var.sku_name
  soft_delete_retention_days = var.soft_delete_retention_days
  purge_protection_enabled   = var.purge_protection_enabled

  admin_object_ids = [for group in data.azuread_group.admin_groups : group.object_id]

  lifecycle {
    ignore_changes = [tags]
  }
}
