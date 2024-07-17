data "azurerm_container_app_environment" "container_environment" {
  name                = var.container_app_environment_settings.name
  resource_group_name = var.container_app_environment_settings.resource_group_name
}

data "azurerm_user_assigned_identity" "identity" {
  name                = var.managed_identity_settings.name
  resource_group_name = var.managed_identity_settings.resource_group_name
}

data "azurerm_container_registry" "container_registry" {
  name                = "nmbrs"
  resource_group_name = "rg-acr-prod"
}
