data "azurerm_subnet" "service_plan" {
  name                 = var.network_settings.subnet_name
  virtual_network_name = var.network_settings.vnet_name
  resource_group_name  = var.network_settings.vnet_resource_group_name
}

data "azurerm_user_assigned_identity" "identity" {
  name                = "mi-identity-test"
  resource_group_name = var.managed_identities[0].resource_group_name
}