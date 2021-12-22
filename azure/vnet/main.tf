resource "azurerm_virtual_network" "vnet" {
  name                = "${var.project}-${var.environment}"
  location            = local.location
  resource_group_name = var.resource_group_name
  address_space       = ["${var.address_space}"]
}

resource "azurerm_subnet" "vnet" {
  for_each = var.subnet_prefixes
  name                 = each.key
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     =  [each.value]
}