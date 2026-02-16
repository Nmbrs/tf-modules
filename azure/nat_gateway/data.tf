data "azurerm_subnet" "vnet" {
  for_each             = toset(var.network_settings.subnets)
  name                 = each.value
  virtual_network_name = var.network_settings.vnet_name
  resource_group_name  = var.network_settings.vnet_resource_group_name
}
