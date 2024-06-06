resource "azurerm_private_endpoint" "endpoint" {
  name                          = local.private_endpoint_name
  location                      = var.location
  resource_group_name           = var.resource_group_name
  subnet_id                     = data.azurerm_subnet.subnet.id
  custom_network_interface_name = "nic-${local.private_endpoint_name}"

  private_service_connection {
    name                           = ("${var.workload}-private-service-connection")
    private_connection_resource_id = local.resource_data_blocks[var.resource_settings.types[0]][0].id
    subresource_names              = var.resource_settings.types
    is_manual_connection           = false
  }
  # [local.subresource_names[var.resource_settings.type]]
  private_dns_zone_group {
    name                 = data.azurerm_private_dns_zone.private_dns_zone.name
    private_dns_zone_ids = [data.azurerm_private_dns_zone.private_dns_zone.id]
  }

  lifecycle {
    ignore_changes = [tags]
  }
}
# ["app_service", "storage_account_blob", "storage_account_table", "storage_account_file", "sql_server"]