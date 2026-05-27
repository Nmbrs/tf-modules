module "private_endpoint" {
  source = "git::github.com/Nmbrs/tf-modules//azure/private_endpoint?ref=feef6f5d286325f373a6edc382c3c00897fe46b9"

  resource_group_name = var.resource_group_name
  location            = var.location

  resource_settings = {
    name             = azurerm_key_vault.key_vault.name
    resource_id      = azurerm_key_vault.key_vault.id
    subresource_name = "vault"
  }

  network_settings    = var.network_settings
  private_dns_zone_id = var.private_dns_zone_id
}
