data "azurerm_subnet" "container_app_environment" {
  name                 = var.network_settings.subnet_name
  virtual_network_name = var.network_settings.vnet_name
  resource_group_name  = var.network_settings.vnet_resource_group_name
}

data "azurerm_log_analytics_workspace" "workspace" {
  name                = var.log_analytics_worspace_settings.name
  resource_group_name = var.log_analytics_worspace_settings.resource_group_name
}

# data "azurerm_key_vault" "access_key" {
#   for_each = { for settings in file_share_settings : settings => settings.name }
#   name                = each.value.storage_account.access_key.key_vault_name
#   resource_group_name = each.value.storage_account.access_key.key_vault_resource_group_name
# }

# data "azurerm_key_vault_secret" "access_key" {
#   for_each = { for settings in file_share_settings : settings => settings.name }
#   name         = each.value.key_vault_secret_name
#   key_vault_id = data.azurerm_key_vault.access_key[each.key].id
# }

# data "azurerm_key_vault" "certificate" {
#   for_each            = { for certificate in var.ssl_certificates : certificate.name => certificate }
#   name                = each.value.key_vault_name
#   resource_group_name = each.value.key_vault_resource_group_name
# }

# data "azurerm_key_vault_secret" "certificate" {
#   for_each     = { for certificate in var.ssl_certificates : certificate.name => certificate }
#   name         = each.value.key_vault_certificate_name
#   key_vault_id = data.azurerm_key_vault.certificate[each.key].id
# }
