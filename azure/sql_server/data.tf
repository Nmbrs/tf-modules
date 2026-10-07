data "azuread_group" "azuread_sql_admin" {
  display_name     = var.admin_settings.azuread_group_name
  security_enabled = true
}

data "azurerm_storage_account" "auditing_storage_account" {
  count               = local.auditing_enabled ? 1 : 0
  name                = var.auditing_settings.storage_account_name
  resource_group_name = var.auditing_settings.storage_account_resource_group
}
