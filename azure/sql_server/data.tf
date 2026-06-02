data "azuread_group" "azuread_sql_admin" {
  display_name     = var.admin_settings.azuread_group_name
  security_enabled = true
}

data "azurerm_subnet" "subnet" {
  for_each = {
    for subnet in var.firewall_settings.allowed_subnets : subnet.subnet_name => subnet
    if var.firewall_settings.public_network_access_enabled
  }
  name                 = each.value.subnet_name
  virtual_network_name = each.value.vnet_name
  resource_group_name  = each.value.vnet_resource_group_name
}

data "azurerm_storage_account" "auditing_storage_account" {
  count               = var.auditing_settings != null && local.audit_enabled ? 1 : 0
  name                = var.auditing_settings.storage_account_name
  resource_group_name = var.auditing_settings.storage_account_resource_group
}

data "azurerm_key_vault_secret" "local_sql_admin_password" {
  name         = var.admin_settings.local_password_secret.secret_name
  key_vault_id = var.admin_settings.local_password_secret.key_vault_id
}
