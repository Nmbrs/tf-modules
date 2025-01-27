resource "azurerm_private_endpoint" "endpoint" {
  name                          = local.private_endpoint_name
  location                      = var.location
  resource_group_name           = var.resource_group_name
  subnet_id                     = data.azurerm_subnet.subnet.id
  custom_network_interface_name = "nic-${local.private_endpoint_name}"

  private_service_connection {
    name                           = local.service_connection_name
    private_connection_resource_id = local.resource_data_blocks[var.resource_settings.type][0].id
    subresource_names              = [local.subresource_name[var.resource_settings.type]]
    is_manual_connection           = false
  }

  private_dns_zone_group {
    name                 = lower(element(split("/", var.private_dns_zone_id), length(split("/", var.private_dns_zone_id)) - 1))
    private_dns_zone_ids = [var.private_dns_zone_id]
  }

  lifecycle {
    ignore_changes = [tags]
  }
}
