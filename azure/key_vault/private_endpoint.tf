module "private_endpoint" {
  source   = "git::github.com/Nmbrs/tf-modules//azure/private_endpoint?ref=49dc7f61a161fb90b42471ba30c15157384b6035"
  for_each = toset(local.private_endpoint_subresources)

  resource_group_name = var.resource_group_name
  location            = var.location

  resource_settings = {
    name             = azurerm_key_vault.key_vault.name
    resource_id      = azurerm_key_vault.key_vault.id
    subresource_name = each.key
  }

  network_settings    = var.network_settings
  private_dns_zone_id = var.private_dns_zone_ids[each.key]
}
