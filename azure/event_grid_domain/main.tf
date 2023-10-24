resource "azurerm_eventgrid_domain" "domain" {
  name                          = local.event_grid_domain_name
  location                      = var.location
  resource_group_name           = var.resource_group_name
  public_network_access_enabled = var.public_network_access_enabled

  identity {
    type = "SystemAssigned"
  }

  lifecycle {
    ignore_changes = [tags]
  }
}
