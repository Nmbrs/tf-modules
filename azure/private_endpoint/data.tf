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
  resource_group_name = var.resource_group_name_private_dns_zone_group
}

data "azurerm_windows_web_app" "app_service" {
  count               = var.resource_type == "app_service" ? 1 : 0
  name                = var.resource_name
  resource_group_name = var.resource_group_name
}

data "azurerm_storage_account" "storage_account" {
  count               = var.resource_type == "storage_account" ? 1 : 0
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
