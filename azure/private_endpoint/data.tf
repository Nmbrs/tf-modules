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
  name                = var.private_dns_zone_group
  resource_group_name = var.resource_group_name_private_dns_zone_group
}

data "azurerm_windows_web_app" "app_service" {
  count               = var.resource_type_id == "app_service" ? 1 : 0
  name                = var.resource_name_id
  resource_group_name = var.resource_group_name_id
  # Add other app_service-specific attributes here
}

data "azurerm_storage_account" "storage_account" {
  count               = var.resource_type_id == "storage_account" ? 1 : 0
  name                = var.resource_name_id
  resource_group_name = var.resource_group_name_id
  # Add other storage_account-specific attributes here
}

data "azurerm_mssql_server" "sql_server" {
  count               = var.resource_type_id == "sql_server" ? 1 : 0
  name                = var.resource_name_id
  resource_group_name = var.resource_group_name_id
  # Add other sql_server-specific attributes here
}