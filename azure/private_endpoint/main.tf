resource "azurerm_private_endpoint" "endpoint" {
  name                = ("${var.private_endpoint_name}-private-endpoint") #name of the NIC, set it for the service name
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = data.azurerm_subnet.subnet.id

  dynamic "private_service_connection" {
    for_each = local.resource_data_blocks[var.resource_type_id] != null ? [1] : []
    content {
      name                           = ("${var.private_endpoint_name}-private-service-connection")
      private_connection_resource_id = local.resource_data_blocks[var.resource_type_id][0].id
      subresource_names              = tolist([lookup(local.subresource_names, var.resource_type_id, null)])
      is_manual_connection           = false
    }
  }
  private_dns_zone_group {
    name                 = var.private_dns_zone_group
    private_dns_zone_ids = tolist([data.azurerm_private_dns_zone.private_dns_zone.id])
  }

  lifecycle {
    ignore_changes = [tags]
  }
}

resource "azurerm_private_dns_zone_virtual_network_link" "virtual_network_link" {
  name                  = ("link-${var.virtual_network}")
  resource_group_name   = var.resource_group_name_private_dns_zone_group
  private_dns_zone_name = data.azurerm_private_dns_zone.private_dns_zone.name
  virtual_network_id    = data.azurerm_virtual_network.vnet.id
  registration_enabled  = true

  lifecycle {
    ignore_changes = [tags]
  }
}

#add validations on subnames
