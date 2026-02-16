output "name" {
  description = "The Resource Group name."
  value       = azurerm_resource_group.main.name
}

output "workload" {
  description = "The resource group workload name."
  value       = var.workload
}

output "id" {
  description = "The ID of the Resource Group."
  value       = azurerm_resource_group.main.id
}

output "location" {
  description = "The Azure Region where the Resource Group exists."
  value       = azurerm_resource_group.main.location
}

output "tags" {
  description = "A mapping of tags assigned to the Resource Group."
  value       = azurerm_resource_group.main.tags
}
