module "private_endpoint" {
  # TODO: update ref to the commit that includes the PEP module's subnet_id refactor (this branch HEAD after PR merge).
  source   = "git::github.com/Nmbrs/tf-modules//azure/private_endpoint?ref=49dc7f61a161fb90b42471ba30c15157384b6035"
  for_each = toset(local.private_endpoint_subresources)

  resource_group_name = var.resource_group_name
  location            = var.location

  resource_settings = {
    name             = azurerm_servicebus_namespace.main.name
    resource_id      = azurerm_servicebus_namespace.main.id
    subresource_name = each.key
  }

  subnet_id           = var.private_endpoint_settings.subnet_id
  private_dns_zone_id = var.private_endpoint_settings.private_dns_zone_ids[each.key]
}
