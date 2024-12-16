resource "azurerm_cdn_frontdoor_profile" "profile" {
  name                = local.frontdoor_profile_name
  resource_group_name = var.resource_group_name
  sku_name            = local.sku_name[var.sku_name]
}
