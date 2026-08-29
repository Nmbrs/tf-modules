module "private_endpoint" {
  source   = "git::github.com/Nmbrs/tf-modules//azure/private_endpoint?ref=f41a116c9f31892191b5e3f146a1e361bfc57322"
  for_each = var.private_endpoint_settings == null ? toset([]) : toset(local.private_endpoint_subresources)

  resource_group_name = var.resource_group_name
  location            = var.location

  resource_settings = {
    name             = azurerm_container_registry.main.name
    resource_id      = azurerm_container_registry.main.id
    subresource_name = each.key
  }

  subnet_id           = var.private_endpoint_settings.subnet_id
  private_dns_zone_id = var.private_endpoint_settings.private_dns_zone_ids[each.key]
}
