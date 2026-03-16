data "azurerm_client_config" "current" {}

data "azurerm_subnet" "subnet" {
  # The ID of the gateway subnet of a virtual network in which the virtual network gateway will be created. It is mandatory that the associated subnet is named GatewaySubnet.
  # Therefore, each virtual network can contain at most a single Virtual Network Gateway.
  name                 = "GatewaySubnet"
  virtual_network_name = var.network_settings.vnet_name
  resource_group_name  = var.network_settings.vnet_resource_group_name
}
