# principal
data "azuread_service_principal" "managed_identity" {
  count        = var.principal_type == "managed_identity" ? 1 : 0
  display_name = var.principal_name
}

data "azuread_service_principal" "service_principal" {
  count        = var.principal_type == "service_principal" ? 1 : 0
  display_name = var.principal_name
}

data "azuread_group" "security_group" {

  count        = var.principal_type == "security_group" ? 1 : 0
  display_name = var.principal_name
}

data "azuread_user" "user" {
  count               = var.principal_type == "user" ? 1 : 0
  user_principal_name = var.principal_name
}

# resources
data "azurerm_resource_group" "resource_group" {
  for_each = {
    for resource in var.resources : lower(resource.name) => resource
    if resouce.type == "resource_group"
  }
  name = each.value.name
}

data "azurerm_key_vault" "key_vault" {
  for_each = {
    for resource in var.resources : lower(resource.name) => resource
    if resouce.type == "key_vault"
  }
  name                = var.resource_settings.name
  resource_group_name = var.resource_settings.resource_group_name
}

data "azurerm_storage_account" "storage_account" {
  for_each = {
    for resource in var.resources : lower(resource.name) => resource
    if resouce.type == "storage_account"
  }
  name                = var.resource_settings.name
  resource_group_name = var.resource_settings.resource_group_name
}

data "azurerm_servicebus_namespace" "service_bus" {
  for_each = {
    for resource in var.resources : lower(resource.name) => resource
    if resouce.type == "service_bus"
  }
  name                = var.resource_settings.name
  resource_group_name = var.resource_settings.resource_group_name
}

data "azurerm_app_configuration" "app_configuration" {
  for_each = {
    for resource in var.resources : lower(resource.name) => resource
    if resouce.type == "app_configuration"
  }
  name                = var.resource_settings.name
  resource_group_name = var.resource_settings.resource_group_name
}
