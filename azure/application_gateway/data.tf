data "azurerm_subnet" "app_gw" {
  name                 = var.subnet_name
  virtual_network_name = var.virtual_network_name
  resource_group_name  = var.rg_network
}

data "azurerm_public_ip" "app_gw" {
  name                = var.public_ip_name
  resource_group_name = var.rg_public_ip
}

data "azurerm_key_vault" "certificate" {
  name                = var.key_vault_name
  resource_group_name = var.rg_key_vault
}

data "azurerm_key_vault_secret" "certificate" {
  name         = var.secret_certificate_name
  key_vault_id = data.azurerm_key_vault.certificate.id
}

data "azurerm_user_assigned_identity" "certificate" {
  name                = var.managed_identity
  resource_group_name = var.rg_managed_identity
}
