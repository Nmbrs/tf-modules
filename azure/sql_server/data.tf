data "azuread_group" "azuread_sql_admin" {
  display_name     = var.azuread_sql_admin
  security_enabled = true
}

data "azurerm_subnet" "subnet" {
  for_each = {
    for subnet in var.public_network_settings.allowed_subnets : subnet.subnet_name => subnet
    if var.public_network_settings.access_enabled
  }
  name                 = each.value.subnet_name
  virtual_network_name = each.value.virtual_network_name
  resource_group_name  = each.value.subnet_resource_group_name
}

data "azurerm_storage_account" "auditing_storage_account" {
  name                = var.storage_account_auditing_settings.storage_account_name
  resource_group_name = var.storage_account_auditing_settings.storage_account_resource_group
}

data "azurerm_key_vault" "local_sql_admin_key_vault" {
  name                = var.local_sql_admin_settings.key_vault_name
  resource_group_name = var.local_sql_admin_settings.key_vault_resource_group
}

data "azurerm_key_vault_secret" "local_sql_admin_password" {
  name         = var.local_sql_admin_settings.key_vault_secret_name
  key_vault_id = data.azurerm_key_vault.local_sql_admin_key_vault.id
}
