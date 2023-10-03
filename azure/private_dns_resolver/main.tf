data "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  resource_group_name = var.vnet_resource_group_name
}

resource "azurerm_private_dns_resolver" "resolver" {
  location            = var.location
  name                = local.dns_resolver_name
  resource_group_name = var.resource_group_name
  virtual_network_id  = data.azurerm_virtual_network.vnet.id

  lifecycle {
    ignore_changes = [tags]
  }
}

data "azurerm_subnet" "inbound_endpoint" {
  for_each             = toset(var.inbound_endpoints)
  name                 = each.value
  virtual_network_name = var.vnet_name
  resource_group_name  = var.vnet_resource_group_name
}

resource "azurerm_private_dns_resolver_inbound_endpoint" "inbound_endpoint" {
  for_each                = toset(var.inbound_endpoints)
  name                    = each.value
  private_dns_resolver_id = azurerm_private_dns_resolver.resolver.id
  location                = azurerm_private_dns_resolver.resolver.location
  ip_configurations {
    private_ip_allocation_method = "Dynamic"
    subnet_id                    = data.azurerm_subnet.inbound_endpoint[each.value].id
  }

  lifecycle {
    ignore_changes = [tags]
  }
}

data "azurerm_subnet" "outbound_endpoint" {
  for_each             = toset(var.outbound_endpoints)
  name                 = each.value
  virtual_network_name = var.vnet_name
  resource_group_name  = var.vnet_resource_group_name
}

resource "azurerm_private_dns_resolver_outbound_endpoint" "outbound_endpoint" {
  for_each                = toset(var.outbound_endpoints)
  name                    = each.value
  private_dns_resolver_id = azurerm_private_dns_resolver.resolver.id
  location                = azurerm_private_dns_resolver.resolver.location
  subnet_id               = data.azurerm_subnet.outbound_endpoint[each.value].id

  lifecycle {
    ignore_changes = [tags]
  }
}

