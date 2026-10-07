output "id" {
  description = "The private endpoint ID."
  value       = azurerm_private_endpoint.endpoint.id
}

output "name" {
  description = "The private endpoint name."
  value       = azurerm_private_endpoint.endpoint.name
}

output "private_ip_address" {
  description = "The private IP address associated with the private endpoint."
  value       = azurerm_private_endpoint.endpoint.private_service_connection[0].private_ip_address
}

output "network_interface_id" {
  description = "The ID of the network interface associated with the private endpoint."
  value       = azurerm_private_endpoint.endpoint.network_interface[0].id
}
