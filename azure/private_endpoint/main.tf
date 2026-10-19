resource "azurerm_private_endpoint" "endpoint" {
  name                          = local.private_endpoint_name
  location                      = var.location
  resource_group_name           = var.resource_group_name
  subnet_id                     = var.subnet_id
  custom_network_interface_name = "nic-${local.private_endpoint_name}"

  private_service_connection {
    name                           = local.service_connection_name
    private_connection_resource_id = var.resource_settings.resource_id
    subresource_names              = [var.resource_settings.subresource_name]
    is_manual_connection           = false
  }

  private_dns_zone_group {
    name                 = lower(reverse(split("/", var.private_dns_zone_id))[0])
    private_dns_zone_ids = [var.private_dns_zone_id]
  }

  lifecycle {
    ignore_changes = [tags]
  }
}
