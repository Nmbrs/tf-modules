output "api_name" {
  value = azurerm_api_management_api.api.name
}

output "api_management_name" {
  value = azurerm_api_management.api.name
}

output "resource_group" {
  value = azurerm_api_management_api.api.resource_group_name
}