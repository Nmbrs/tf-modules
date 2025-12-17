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

output "admin_username" {
  description = "The username associated with the Container Registry admin account."
  value       = azurerm_container_registry.main.admin_username
  sensitive   = true
}

output "admin_password" {
  description = "The password associated with the Container Registry admin account."
  value       = azurerm_container_registry.main.admin_password
  sensitive   = true
}

output "identity" {
  description = "The identity block of the Container Registry."
  value       = azurerm_container_registry.main.identity
}
