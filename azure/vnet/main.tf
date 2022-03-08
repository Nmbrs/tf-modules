resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  address_space       = var.address_space
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = var.tags
}

resource "azurerm_subnet" "subnet" {
  for_each = { for subnet in var.subnets : subnet.name => subnet }

  name                                           = each.key
  resource_group_name                            = var.resource_group_name
  virtual_network_name                           = azurerm_virtual_network.vnet.name
  address_prefixes                               = each.value.address_prefixes
  service_endpoints                              = lookup(each.value, "service_endpoints", [])  
  enforce_private_link_service_network_policies  = lookup(each.value, "enforce_private_link_service_network_policies", false)
  enforce_private_link_endpoint_network_policies = lookup(each.value, "enforce_private_link_endpoint_network_policies", false)

  dynamic "delegation" {
    for_each = lookup(each.value, "delegation", null) != null ? [""] : []
    content {
      name = each.value.delegation
      service_delegation {
        name    = each.value.delegation
        actions = formatlist("Microsoft.Network/%s", local.service_delegation_actions[each.value.delegation])
      }
    }
  }
}

