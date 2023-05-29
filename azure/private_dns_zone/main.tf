
resource "azurerm_private_dns_zone" "private_dns_zone" {
  name                = lower(var.name)
  resource_group_name = var.resource_group_name

  lifecycle {
    ignore_changes = [tags]
  }
}

data "azurerm_virtual_network" "vnet" {
  for_each = { for vnet_link in var.vnet_links : vnet_link.vnet_name => vnet_link }

  name                = each.value.vnet_name
  resource_group_name = each.value.vnet_resource_group
}

resource "random_id" "vnet_link" {
  for_each = { for vnet_link in var.vnet_links : vnet_link.vnet_name => vnet_link }

  byte_length = 4
  keepers = {
    vnet_name = lower(each.value.vnet_name)
  }
}

resource "azurerm_private_dns_zone_virtual_network_link" "vnet_link" {
  for_each = { for vnet_link in var.vnet_links : vnet_link.vnet_name => vnet_link }

  name                  = "vlink-${each.value.vnet_name}-${random_id.vnet_link[each.key].hex}"
  resource_group_name   = each.value.vnet_resource_group
  private_dns_zone_name = azurerm_private_dns_zone.private_dns_zone.name
  virtual_network_id    = data.azurerm_virtual_network.vnet[each.key].id
  registration_enabled  = each.value.registration_enabled

  lifecycle {
    ignore_changes = [tags]
  }
}
