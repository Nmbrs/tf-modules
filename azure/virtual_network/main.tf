resource "azurerm_virtual_network" "vnet" {
  name                = local.vnet_name
  location            = var.location
  resource_group_name = var.resource_group_name
  address_space       = var.address_spaces

  ddos_protection_plan {
    id     = var.ddos_plan_settings.resource_id
    enable = var.ddos_plan_settings.enabled
  }

  lifecycle {
    ignore_changes = [tags]
  }
}

resource "azurerm_subnet" "subnet" {
  for_each = { for subnet in var.subnets : subnet.name => subnet }

  name                              = each.value.name
  resource_group_name               = var.resource_group_name
  virtual_network_name              = azurerm_virtual_network.vnet.name
  address_prefixes                  = each.value.address_prefixes
  default_outbound_access_enabled   = true
  service_endpoints                 = lookup(each.value, "service_endpoints", [])
  private_endpoint_network_policies = lookup(each.value, "private_endpoint_network_policies_enabled", true) ? "Enabled" : "Disabled"
  # In order to deploy a Private Link Service on a given subnet, you must set the private_link_service_network_policies_enabled attribute to false.
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
