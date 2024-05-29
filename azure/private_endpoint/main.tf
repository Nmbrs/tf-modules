resource "azurerm_private_endpoint" "endpoint" {
  name                          = local.private_endpoint_name
  location                      = var.location
  resource_group_name           = var.resource_group_name
  subnet_id                     = data.azurerm_subnet.subnet.id
  custom_network_interface_name = "nic-${local.private_endpoint_name}"

  dynamic "private_service_connection" {
    for_each = local.resource_data_blocks[var.resource_type] != null ? [1] : []
    content {
      name                           = ("${var.workload}-private-service-connection")
      private_connection_resource_id = local.resource_data_blocks[var.resource_type][0].id
      subresource_names              = tolist([lookup(local.subresource_names, var.resource_type, null)])
      is_manual_connection           = false
    }
  }

  private_dns_zone_group {
    name                 = data.azurerm_private_dns_zone.private_dns_zone.name
    private_dns_zone_ids = tolist([data.azurerm_private_dns_zone.private_dns_zone.id])
  }

  lifecycle {
    ignore_changes = [tags]
  }
}
