output "id" {
  description = "The ID of the Container Registry."
  value       = azurerm_container_registry.main.id
}

output "name" {
  description = "The name of the Container Registry."
  value       = azurerm_container_registry.main.name
}

output "login_server" {
  description = "The URL that can be used to log into the container registry."
  value       = azurerm_container_registry.main.login_server
}
