output "name" {
  value       = azurerm_virtual_network_gateway.vpn_gateway.name
  description = "The name of the VPN Gateway."
}

output "id" {
  value       = azurerm_virtual_network_gateway.vpn_gateway.id
  description = "The ID of the VPN Gateway."
}
