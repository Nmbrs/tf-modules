data "azuread_group" "sql_admin" {
  display_name     = var.sql_admin
  security_enabled = true
}

data "azurerm_subnet" "subnet" {
  name                 = var.subnet_name
  virtual_network_name = var.virtual_network_name
  resource_group_name  = var.subnet_resource_group_name
}