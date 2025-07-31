resource "azurerm_public_ip" "natgw" {
  name                = local.public_ip_name
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
  zones               = ["1"]

  lifecycle {
    ignore_changes = [tags]
  }
}

# ==============================================================================
# NAT Gateway Configuration
# ==============================================================================

resource "azurerm_nat_gateway" "natgw" {
  name                    = local.nat_gateway_name
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
  for_each       = toset(var.network_settings.subnets)
  subnet_id      = data.azurerm_subnet.vnet[each.key].id
  nat_gateway_id = azurerm_nat_gateway.natgw.id
}
