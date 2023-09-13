resource "azurerm_resource_group" "rg" {
  name     = "rg-${var.name}-${var.environment}"
  location = var.location
  tags     = merge(local.default_tags, var.extra_tags)

  lifecycle {
    ignore_changes = [tags]
  }
}
