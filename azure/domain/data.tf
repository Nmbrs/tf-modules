data "azurerm_resource_group" "app_service_domain" {
  name     = var.resource_group_name
}

data "azurerm_dns_zone" "app_service_domain" {
  name                = var.name
  resource_group_name = var.resource_group_name
}