resource "azurerm_resource_group" "rg" {
  name     = "rg-${var.name}-${var.environment}"
  location = var.location
  tags     = var.tags

  lifecycle {
    ignore_changes = [tags]
  }
}
