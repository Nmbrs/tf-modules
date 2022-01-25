resource "azurerm_resource_group" "rg" {
  name     = "rg-${var.project}-${var.tags["environment"]}"
  location = local.location
  tags     = var.tags
}