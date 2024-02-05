data "azurerm_virtual_network" "vnet" {
  name                = var.virtual_network
  resource_group_name = var.resource_group_name_virtual_network
}

data "azurerm_subnet" "subnet" {
  name                 = var.subnet_name
  virtual_network_name = var.virtual_network
  resource_group_name  = var.resource_group_name_virtual_network
}

data "azurerm_private_dns_zone" "private_dns_zone" {
  name                = lookup(local.private_dns_zones, var.resource_type, null)
  resource_group_name = var.resource_group_name_private_dns_zone
}

data "azurerm_windows_web_app" "app_service" {
  count               = var.resource_type == "app_service" ? 1 : 0
  name                = var.resource_name
  resource_group_name = var.resource_group_name
}

data "azurerm_storage_account" "storage_account_blob" {
  count               = var.resource_type == "storage_account_blob" ? 1 : 0
  name                = var.resource_name
  resource_group_name = var.resource_group_name
}

data "azurerm_storage_account" "storage_account_table" {
  count               = var.resource_type == "storage_account_table" ? 1 : 0
  name                = var.resource_name
  resource_group_name = var.resource_group_name
}

data "azurerm_storage_account" "storage_account_file" {
  count               = var.resource_type == "storage_account_file" ? 1 : 0
  name                = var.resource_name
  resource_group_name = var.resource_group_name
}


data "azurerm_mssql_server" "sql_server" {
  count               = var.resource_type == "sql_server" ? 1 : 0
  name                = var.resource_name
  resource_group_name = var.resource_group_name
}

data "azurerm_key_vault" "key_vault" {
  count               = var.resource_type == "key_vault" ? 1 : 0
  name                = var.resource_name
  resource_group_name = var.resource_group_name
}

data "azurerm_servicebus_namespace" "service_bus" {
  count               = var.resource_type == "service_bus" ? 1 : 0
  name                = var.resource_name
  resource_group_name = var.resource_group_name
}

data "azurerm_eventgrid_domain" "eventgrid_domain" {
  count               = var.resource_type == "eventgrid_domain" ? 1 : 0
  name                = var.resource_name
  resource_group_name = var.resource_group_name
}

data "azurerm_eventgrid_topic" "eventgrid_topic" {
  count               = var.resource_type == "eventgrid_topic" ? 1 : 0
  name                = var.resource_name
  resource_group_name = var.resource_group_name
}

data "azurerm_container_registry" "container_registry" {
  count               = var.resource_type == "container_registry" ? 1 : 0
  name                = var.resource_name
  resource_group_name = var.resource_group_name
}
