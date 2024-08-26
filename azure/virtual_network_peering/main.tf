data "azurerm_virtual_network" "vnet_source" {
  name                = var.vnet_source.name
  resource_group_name = var.vnet_source.resource_group_name
}

data "azurerm_virtual_network" "vnet_destination" {
  name                = var.vnet_destination.name
  resource_group_name = var.vnet_destination.resource_group_name
}

resource "azurerm_virtual_network_peering" "vnet_source" {
  name                         = local.source_peering_name
  virtual_network_name         = var.vnet_source.name
  resource_group_name          = var.vnet_source.resource_group_name
  remote_virtual_network_id    = data.azurerm_virtual_network.vnet_destination.id
  use_remote_gateways          = var.vnet_source.use_remote_gateways
  allow_gateway_transit        = var.vnet_source.allow_gateway_transit
  allow_forwarded_traffic      = var.vnet_source.allow_forwarded_traffic
  allow_virtual_network_access = var.vnet_source.allow_virtual_network_access
}

resource "azurerm_virtual_network_peering" "vnet_destnation" {
  name                         = local.destination_peering_name
  virtual_network_name         = var.vnet_destination.name
  resource_group_name          = var.vnet_destination.resource_group_name
  remote_virtual_network_id    = data.azurerm_virtual_network.vnet_source.id
  use_remote_gateways          = var.vnet_destination.use_remote_gateways
  allow_gateway_transit        = var.vnet_destination.allow_gateway_transit
  allow_forwarded_traffic      = var.vnet_destination.allow_forwarded_traffic
  allow_virtual_network_access = var.vnet_destination.allow_virtual_network_access
}
