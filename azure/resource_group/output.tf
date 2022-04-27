output "name" {
  description = "The Resource Group name."
  value       = azurerm_resource_group.rg.name
}

output "id" {
  description = "The ID of the Resource Group."
  value       = azurerm_resource_group.rg.id
}

output "location" {
  description = "The Azure Region where the Resource Group exists."
  value       = azurerm_resource_group.rg.location
}

output "tags" {
  description = "A mapping of tags assigned to the Resource Group."
  value       = azurerm_resource_group.rg.tags
}
