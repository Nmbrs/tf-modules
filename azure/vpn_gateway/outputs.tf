output "name" {
  description = "The VPN gateway full name."
  value       = azurerm_virtual_network_gateway.vpn_gateway.name
}

output "workload" {
  description = "The VPN gateway workload."
  value       = var.workload
}

output "id" {
  description = "The VPN gateway ID."
  value       = azurerm_virtual_network_gateway.vpn_gateway.id

}
