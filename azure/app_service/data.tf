data "azurerm_subnet" "service_plan" {
  name                 = var.network_settings.subnet_name
  virtual_network_name = var.network_settings.vnet_name
  resource_group_name  = var.network_settings.vnet_resource_group_name
}

data "azurerm_user_assigned_identity" "managed_identity" {
  name                = var.managed_identity_settings.name
  resource_group_name = var.managed_identity_settings.resource_group_name
}

data "azurerm_application_insights" "app_insights_settings" {
  name                = var.app_insights_settings.name
  resource_group_name = var.app_insights_settings.resource_group_name
}