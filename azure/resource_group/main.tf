resource "azurecaf_name" "caf_name" {
  name          = lower(var.name)
  resource_type = "azurerm_resource_group"
  clean_input   = true
}

resource "azurerm_resource_group" "rg" {
  name     = azurecaf_name.caf_name.result
  location = var.location
  tags     = merge(local.default_tags, var.extra_tags)

  lifecycle {
    ignore_changes = [
      tags["created_at"],
      tags["updated_at"]
    ]
  }
}
