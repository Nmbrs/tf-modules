data "azurerm_client_config" "current" {}

data "azurerm_subnet" "subnet" {
  # The ID of the gateway subnet of a virtual network in which the virtual network gateway will be created. It is mandatory that the associated subnet is named GatewaySubnet. 
  # Therefore, each virtual network can contain at most a single Virtual Network Gateway.
  name                 = "GatewaySubnet"
  virtual_network_name = var.vnet_name
  resource_group_name  = var.vnet_resource_group_name
}

resource "azurerm_public_ip" "vpn_gateway" {
  name                = "pip-vpng-${var.name}-${var.environment}"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"

  lifecycle {
    ignore_changes = [tags]
  }
}

resource "azurerm_virtual_network_gateway" "vpn_gateway" {
  name                = "vpng-${var.name}-${var.environment}"
  location            = var.location
  resource_group_name = var.vnet_resource_group_name

  type     = "Vpn"
  vpn_type = "RouteBased"

  active_active = false
  enable_bgp    = false
  sku           = var.sku
  generation    = var.generation

  ip_configuration {
    name                          = azurerm_public_ip.vpn_gateway.name
    public_ip_address_id          = azurerm_public_ip.vpn_gateway.id
    private_ip_address_allocation = "Dynamic"
    subnet_id                     = data.azurerm_subnet.subnet.id
  }

  vpn_client_configuration {
    address_space        = var.address_space
    vpn_client_protocols = ["OpenVPN"]

    # Learn more about Azure AD authentication https://learn.microsoft.com/en-us/azure/vpn-gateway/openvpn-azure-ad-tenant
    aad_tenant   = local.aad_tenant_url
    aad_audience = local.vpn_enterprise_app_id
    aad_issuer   = local.aad_issuer_url
  }
}
