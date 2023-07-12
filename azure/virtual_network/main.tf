data "azurerm_client_config" "current" {}

data "azurerm_resource_group" "rg" {
  name = var.resource_group_name
}

resource "azurerm_virtual_network" "vnet" {
  name                = var.name
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
  address_space       = var.address_spaces

  lifecycle {
    ignore_changes = [tags]
  }
}

#VNET peering
data "azurerm_virtual_network" "vnet_destiny" {
  for_each = { for peering in var.vnet_peerings : peering.vnet_name => peering }

  name                = each.value.vnet_name
  resource_group_name = each.value.vnet_resource_group_name
}

resource "azurerm_virtual_network_peering" "vnet_source" {
  for_each = { for peering in var.vnet_peerings : peering.vnet_name => peering }

  name                         = "peering-${azurerm_virtual_network.vnet.name}-to-${each.value.vnet_name}"
  resource_group_name          = data.azurerm_resource_group.rg.name
  virtual_network_name         = azurerm_virtual_network.vnet.name
  remote_virtual_network_id    = data.azurerm_virtual_network.vnet_destiny[each.key].id
  use_remote_gateways          = each.value.use_remote_gateways
  allow_gateway_transit        = each.value.allow_gateway_transit
  allow_forwarded_traffic      = each.value.allow_forwarded_traffic
  allow_virtual_network_access = each.value.allow_virtual_network_access
}

resource "azurerm_virtual_network_peering" "vnet_destiny" {
  for_each = { for peering in var.vnet_peerings : peering.vnet_name => peering }

  name                         = "peering-${each.value.vnet_name}-to-${azurerm_virtual_network.vnet.name}"
  resource_group_name          = data.azurerm_virtual_network.vnet_destiny[each.key].resource_group_name
  virtual_network_name         = data.azurerm_virtual_network.vnet_destiny[each.key].name
  remote_virtual_network_id    = azurerm_virtual_network.vnet.id
  use_remote_gateways          = false # Controls if remote gateways can be used on the local virtual network. Only one peering can have this flag set to true
  allow_gateway_transit        = each.value.allow_gateway_transit
  allow_forwarded_traffic      = each.value.allow_forwarded_traffic
  allow_virtual_network_access = each.value.allow_virtual_network_access
}

# Subnets
resource "azurerm_subnet" "subnet" {
  for_each = { for subnet in var.subnets : subnet.name => subnet }

  name                                          = each.value.name
  resource_group_name                           = data.azurerm_resource_group.rg.name
  virtual_network_name                          = azurerm_virtual_network.vnet.name
  address_prefixes                              = each.value.address_prefixes
  service_endpoints                             = lookup(each.value, "service_endpoints", [])
  private_endpoint_network_policies_enabled     = lookup(each.value, "private_endpoint_network_policies_enabled", true)
  private_link_service_network_policies_enabled = lookup(each.value, "private_link_service_network_policies_enabled", true)

  dynamic "delegation" {
    for_each = each.value.delegations
    content {
      name = delegation.value
      service_delegation {
        name    = delegation.value
        actions = local.service_delegation_actions[delegation.value]
      }
    }
  }
}
