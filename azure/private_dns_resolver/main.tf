data "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  resource_group_name = var.vnet_resource_group_name
}

resource "azurerm_private_dns_resolver" "resolver" {
  location            = var.location
  name                = "dnsres-${lower(var.name)}-${var.environment}"
  resource_group_name = var.resource_group_name
  virtual_network_id  = data.azurerm_virtual_network.vnet.id

  lifecycle {
    ignore_changes = [tags]
  }
}

data "azurerm_subnet" "inbound_endpoint" {
  for_each = { for endpoint in var.inbound_endpoints : endpoint.subnet_name => endpoint }

  name                 = each.value.subnet_name
  virtual_network_name = var.vnet_name
  resource_group_name  = var.vnet_resource_group_name
}

resource "random_id" "inbound_endpoint" {
  for_each = { for endpoint in var.inbound_endpoints : endpoint.subnet_name => endpoint }

  byte_length = 4
  keepers = {
    vnet_name = lower(each.value.subnet_name)
  }
}

resource "azurerm_private_dns_resolver_inbound_endpoint" "inbound_endpoint" {
  for_each = { for endpoint in var.inbound_endpoints : endpoint.subnet_name => endpoint }

  name                    = "inedp-${each.value.subnet_name}-${random_id.inbound_endpoint[each.key].hex}"
  private_dns_resolver_id = azurerm_private_dns_resolver.resolver.id
  location                = azurerm_private_dns_resolver.resolver.location
  ip_configurations {
    private_ip_allocation_method = "Dynamic"
    subnet_id                    = data.azurerm_subnet.inbound_endpoint[each.key].id
  }

  lifecycle {
    ignore_changes = [tags]
  }
}

data "azurerm_subnet" "outbound_endpoint" {
  for_each = { for endpoint in var.outbound_endpoints : endpoint.subnet_name => endpoint }

  name                 = each.value.subnet_name
  virtual_network_name = var.vnet_name
  resource_group_name  = var.vnet_resource_group_name
}

resource "random_id" "outbound_endpoint" {
  for_each = { for endpoint in var.outbound_endpoints : endpoint.subnet_name => endpoint }

  byte_length = 4
  keepers = {
    vnet_name = lower(each.value.subnet_name)
  }
}

resource "azurerm_private_dns_resolver_outbound_endpoint" "outbound_endpoint" {
  for_each = { for endpoint in var.outbound_endpoints : endpoint.subnet_name => endpoint }

  name                    = "outedp-${each.value.subnet_name}-${random_id.outbound_endpoint[each.key].hex}"
  private_dns_resolver_id = azurerm_private_dns_resolver.resolver.id
  location                = azurerm_private_dns_resolver.resolver.location
  subnet_id               = data.azurerm_subnet.outbound_endpoint[each.key].id

  lifecycle {
    ignore_changes = [tags]
  }
}

