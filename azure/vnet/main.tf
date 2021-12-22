data "azurerm_resource_group" "rg" {
  name="rg-network"
}

resource "azurerm_virtual_network" "vnet" {
  name                = "${var.project}-${var.environment}"
  location            = local.location
  resource_group_name = data.azurerm_resource_group.rg.name
  address_space       = ["${var.address_space}"]
}

resource "azurerm_subnet" "vnet" {
  for_each = var.subnet_prefixes
  name                 = each.key
  resource_group_name  = data.azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     =  [each.value]
}