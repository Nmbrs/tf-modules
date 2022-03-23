resource "azurecaf_name" "caf_name" {
  name          = lower(var.name)
  resource_type = "azurerm_resource_group"
  suffixes      = [lower(var.environment)]
  clean_input   = true
}

resource "azurerm_resource_group" "rg" {
  name     = azurecaf_name.caf_name.result
  location = var.location
  tags     = merge(var.extra_tags, local.default_tags)
}
