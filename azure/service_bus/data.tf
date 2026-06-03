data "azurerm_subnet" "allowed_subnet" {
  for_each = {
    for subnet in var.firewall_settings.allowed_subnets : subnet.subnet_name => subnet
  }
  name                 = each.value.subnet_name
  virtual_network_name = each.value.vnet_name
  resource_group_name  = each.value.vnet_resource_group_name
}
