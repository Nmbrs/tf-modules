data "azurerm_subnet" "subnet" {
  name                 = var.network_settings.subnet_name
  virtual_network_name = var.network_settings.vnet_name
  resource_group_name  = var.network_settings.vnet_resource_group_name
}

data "azurerm_private_dns_zone" "private_dns_zone" {
  name                = var.private_dns_zone_settings.use_custom_dns_zone ? var.private_dns_zone_settings.custom_name : lookup(local.private_dns_zones, var.resource_settings.types, null)
  resource_group_name = var.private_dns_zone_settings.resource_group_name
}

data "azurerm_windows_web_app" "app_service" {
  count               = var.resource_settings.types[0] == "app_service" ? 1 : 0
  name                = var.resource_settings.name
  resource_group_name = var.resource_group_name
}

data "azurerm_storage_account" "storage_account_blob" {
  count               = var.resource_settings.types[0] == "storage_account_blob" ? 1 : 0
  name                = var.resource_settings.name
  resource_group_name = var.resource_group_name
}

data "azurerm_storage_account" "storage_account_table" {
  count               = var.resource_settings.types[0] == "storage_account_table" ? 1 : 0
  name                = var.resource_settings.name
  resource_group_name = var.resource_group_name
}

data "azurerm_storage_account" "storage_account_file" {
  count               = var.resource_settings.types[0] == "storage_account_file" ? 1 : 0
  name                = var.resource_settings.name
  resource_group_name = var.resource_group_name
}

data "azurerm_mssql_server" "sql_server" {
  count               = var.resource_settings.types[0] == "sql_server" ? 1 : 0
  name                = var.resource_settings.name
  resource_group_name = var.resource_group_name
}

data "azurerm_key_vault" "key_vault" {
  count               = var.resource_settings.types[0] == "key_vault" ? 1 : 0
  name                = var.resource_settings.name
  resource_group_name = var.resource_group_name
}

data "azurerm_servicebus_namespace" "service_bus" {
  count               = var.resource_settings.types[0] == "service_bus" ? 1 : 0
  name                = var.resource_settings.name
  resource_group_name = var.resource_group_name
}

data "azurerm_eventgrid_domain" "eventgrid_domain" {
  count               = var.resource_settings.types[0] == "eventgrid_domain" ? 1 : 0
  name                = var.resource_settings.name
  resource_group_name = var.resource_group_name
}

data "azurerm_eventgrid_topic" "eventgrid_topic" {
  count               = var.resource_settings.types[0] == "eventgrid_topic" ? 1 : 0
  name                = var.resource_settings.name
  resource_group_name = var.resource_group_name
}

data "azurerm_container_registry" "container_registry" {
  count               = var.resource_settings.types[0] == "container_registry" ? 1 : 0
  name                = var.resource_settings.name
  resource_group_name = var.resource_group_name
}
