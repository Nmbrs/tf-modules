data "azurerm_subnet" "vnet" {
  for_each             = toset(var.subnets)
  name                 = each.value
  virtual_network_name = var.vnet_name
  resource_group_name  = var.vnet_resource_group_name
}

resource "azurerm_public_ip" "natgw" {
  name                = "pip-ngw-${var.name}-${var.environment}-ip"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
  zones               = ["1"]

  lifecycle {
    ignore_changes = [tags]
  }
}

resource "azurerm_nat_gateway" "natgw" {
  name                    = "ngw-${var.name}-${var.environment}"
  location                = var.location
  resource_group_name     = var.resource_group_name
  sku_name                = "Standard"
  idle_timeout_in_minutes = 10
  zones                   = ["1"]

  lifecycle {
    ignore_changes = [tags]
  }
}

resource "azurerm_nat_gateway_public_ip_association" "natgw" {
  nat_gateway_id       = azurerm_nat_gateway.natgw.id
  public_ip_address_id = azurerm_public_ip.natgw.id
}

resource "azurerm_subnet_nat_gateway_association" "natgw" {
  for_each       = toset(var.subnets)
  subnet_id      = data.azurerm_subnet.vnet[each.key].id
  nat_gateway_id = azurerm_nat_gateway.natgw.id
}
