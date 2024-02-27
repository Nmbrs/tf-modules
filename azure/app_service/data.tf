data "azurerm_subnet" "service_plan" {
  name                 = var.network_settings.subnet_name
  virtual_network_name = var.network_settings.vnet_name
  resource_group_name  = var.network_settings.vnet_resource_group_name
}

data "azurerm_user_assigned_identity" "managed_identity" {
  count               = length(var.managed_identity_name) > 1 && length(var.managed_identity_resource_group) > 1 ? 1 : 0
  name                = var.managed_identity_name
  resource_group_name = var.managed_identity_resource_group
}

data "azurerm_application_insights" "app_insights" {
  count               = length(var.app_insights_name) > 1 && length(var.app_insights_resource_group) > 1 ? 1 : 0
  name                = var.app_insights_name
  resource_group_name = var.app_insights_resource_group
}