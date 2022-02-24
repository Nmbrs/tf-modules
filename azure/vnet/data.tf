data "azurerm_subscription" "current" {}

data "azurerm_resource_group" "network" {
  name = var.resource_group_name
}
