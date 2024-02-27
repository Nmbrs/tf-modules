data "azurerm_subnet" "service_plan" {
  name                 = var.network_settings.subnet_name
  virtual_network_name = var.network_settings.vnet_name
  resource_group_name  = var.network_settings.vnet_resource_group_name
}

data "azurerm_user_assigned_identity" "managed_identity" {
  name                = var.managed_identity_settings.name
  resource_group_name = var.managed_identity_settings.resource_group_name
}

data "azurerm_application_insights" "app_insights" {
  count               = length(var.app_insights_name) > 1 && length(var.app_insights_resource_group) > 1 ? 1 : 0
  name                = var.app_insights_name
  resource_group_name = var.app_insights_resource_group
}