data "azurerm_subnet" "vnet" {
  for_each             = var.subnets
  name                 = each.value.name
  virtual_network_name = each.value.virtual_network_name
  resource_group_name  = each.value.resource_group_name
}

resource "azurerm_public_ip" "natgw" {
  name                = "pip-nsg-${var.name}-${var.environment}-ip"
  location            = local.location
  resource_group_name = var.natgw_resource_group
  allocation_method   = "Static"
  sku                 = "Standard"
  zones               = ["1"]

  lifecycle {
    ignore_changes = [tags]
  }
}

resource "azurerm_nat_gateway" "natgw" {
  name                    = "nsg-${var.name}-${var.environment}"
  location                = local.location
  resource_group_name     = var.natgw_resource_group
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
  for_each       = var.subnets
  subnet_id      = data.azurerm_subnet.vnet[each.key].id
  nat_gateway_id = azurerm_nat_gateway.natgw.id
}
