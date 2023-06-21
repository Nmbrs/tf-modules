data "azurerm_subnet" "vnet" {
  name                 = "GatewaySubnet"
  virtual_network_name = var.vnet_name
  resource_group_name  = var.vnet_resource_group
}

resource "azurerm_public_ip" "vg" {
  name                = "pip-vg-${var.name}-${var.environment}-ip"
  location            = local.location
  resource_group_name = var.vg_resource_group
  allocation_method   = "Static"
  sku                 = "Standard"

  lifecycle {
    ignore_changes = [tags]
  }
}

resource "azurerm_virtual_network_gateway" "vg" {
  name                = "vg-${var.name}-${var.environment}"
  location            = local.location
  resource_group_name = var.vnet_resource_group

  type     = "Vpn"
  vpn_type = "RouteBased"

  active_active = false
  enable_bgp    = false
  sku           = "VpnGw1"

  ip_configuration {
    name                          = azurerm_public_ip.vg.name
    public_ip_address_id          = azurerm_public_ip.vg.id
    private_ip_address_allocation = "Dynamic"
    subnet_id                     = data.azurerm_subnet.vnet.id
  }
  vpn_client_configuration {
    address_space        = var.address_space
    vpn_client_protocols = ["OpenVPN"]
    aad_tenant           = var.aad_tenant
    aad_audience         = var.aad_audience
    aad_issuer           = var.aad_issuer
  }
}
