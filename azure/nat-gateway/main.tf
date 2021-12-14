resource "azurerm_public_ip" "natgw" {
  name                = "${var.project}-${var.environment}-ip"
  location            = local.location
  resource_group_name = var.natgw_resource_group
  allocation_method   = "Static"
  sku                 = "Standard"
  availability_zone   = "1"
}

resource "azurerm_nat_gateway" "natgw" {
  name                    = "${var.project}-${var.environment}"
  location                = local.location
  resource_group_name     = var.natgw_resource_group
  sku_name                = "Standard"
  idle_timeout_in_minutes = 10
  zones                   = ["1"]
}

resource "azurerm_nat_gateway_public_ip_association" "natgw" {
  nat_gateway_id       = "${azurerm_nat_gateway.natgw.id}"
  public_ip_address_id = "${azurerm_public_ip.natgw.id}"
}

data "azurerm_subnet" "natgw" {
  name                              = var.vnet.subnet_name
  virtual_network_name  = var.vnet.virtual_network_name
  resource_group_name  = var.vnet.resource_group_name
}

resource "azurerm_subnet_nat_gateway_association" "natgw" {
  subnet_id      = data.azurerm_subnet.natgw.id
  nat_gateway_id = azurerm_nat_gateway.natgw.id
}