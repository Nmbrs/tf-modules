module "private_endpoint" {
  source   = "git::github.com/Nmbrs/tf-modules//azure/private_endpoint?ref=feef6f5d286325f373a6edc382c3c00897fe46b9"
  for_each = toset(["blob", "table", "file", "queue"])

  resource_group_name = var.resource_group_name
  location            = var.location

  resource_settings = {
    name             = azurerm_storage_account.storage_account.name
    resource_id      = azurerm_storage_account.storage_account.id
    subresource_name = each.key
  }

  network_settings    = var.network_settings
  private_dns_zone_id = var.private_dns_zone_ids[each.key]
}
