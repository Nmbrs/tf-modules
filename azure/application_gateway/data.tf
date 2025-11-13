data "azurerm_subnet" "app_gw" {
  name                 = var.network_settings.subnet_name
  virtual_network_name = var.network_settings.vnet_name
  resource_group_name  = var.network_settings.vnet_resource_group_name
}

data "azurerm_key_vault" "certificate" {
  for_each            = { for certificate in var.ssl_certificates : certificate.name => certificate }
  name                = each.value.key_vault_name
  resource_group_name = each.value.key_vault_resource_group_name
}

data "azurerm_key_vault_secret" "certificate" {
  for_each     = { for certificate in var.ssl_certificates : certificate.name => certificate }
  name         = each.value.key_vault_certificate_name
  key_vault_id = data.azurerm_key_vault.certificate[each.key].id
}

data "azurerm_user_assigned_identity" "certificate" {
  name                = var.managed_identity_settings.name
  resource_group_name = var.managed_identity_settings.resource_group_name
}

data "azurerm_log_analytics_workspace" "diagnostics" {
  name                = var.diagnostic_settings.log_analytics_workspace.name
  resource_group_name = var.diagnostic_settings.log_analytics_workspace.resource_group
}
