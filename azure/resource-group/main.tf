resource "azurecaf_name" "caf_name" {
  name          = var.name
  resource_type = "azurerm_resource_group"
  suffixes      = [var.environment]
  clean_input   = true
}

resource "azurerm_resource_group" "rg" {
  name     = var.name
  location = var.location
  tags     = merge(var.extra_tags, local.default_tags)
}
