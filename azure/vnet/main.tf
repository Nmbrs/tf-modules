data "azurerm_client_config" "current" {}

data "azurerm_resource_group" "rg" {
  name = var.resource_group_name
}

resource "azurerm_virtual_network" "vnet" {
  name                = var.name
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
  address_space       = var.address_spaces
  tags                = merge(local.default_tags, data.azurerm_resource_group.rg.tags, var.extra_tags)
}

# resource "azurerm_subnet" "subnet" {
#   for_each = { for key, value in var.subnets : key => value }
#   # for subnet in var.subnets : subnet.name => subnet }

#   name                                           = each.value.name
#   resource_group_name                            = data.azurerm_resource_group.rg.name
#   virtual_network_name                           = azurerm_virtual_network.vnet.name
#   address_prefix                                 = each.value.address_prefixes
#   service_endpoints                              = lookup(each.value, "service_endpoints", [])
#   enforce_private_link_service_network_policies  = lookup(each.value, "enforce_private_link_service_network_policies", false)
#   enforce_private_link_endpoint_network_policies = lookup(each.value, "enforce_private_link_endpoint_network_policies", false)

  # dynamic "delegation" {
  #   # for subnet in var.subnets : subnet.name => subnet }
  #   for_each = lookup(each.value, "delegation", null) != null ? [""] : []
  #   content {
  #     name = each.value.delegation
  #     service_delegation {
  #       name    = each.value.delegation
  #       actions = formatlist("Microsoft.Network/%s", local.service_delegation_actions[each.value.delegation])
  #     }
  #   }
  # }
# }

