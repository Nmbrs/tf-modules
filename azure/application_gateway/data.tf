data "azurerm_subnet" "app_gw" {
  name                 = var.subnet_name
  virtual_network_name = var.vnet_name
  resource_group_name  = var.vnet_resource_group_name
}

data "azurerm_key_vault" "certificate" {
  name                = var.key_vault_name
  resource_group_name = var.key_vault_resource_group_name
}

data "azurerm_key_vault_secret" "certificate" {
  name         = var.key_vault_certificate_name
  key_vault_id = data.azurerm_key_vault.certificate.id
}

data "azurerm_user_assigned_identity" "certificate" {
  name                = var.managed_identity_name
  resource_group_name = var.managed_identity_resource_group_name
}
