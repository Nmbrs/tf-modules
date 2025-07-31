output "name" {
  description = "The NAT gateway full name."
  value       = azurerm_nat_gateway.natgw.name
}

output "workload" {
  description = "The NAT gateway workload name."
  value       = var.workload
}

output "id" {
  description = "The NAT gateway ID."
  value       = azurerm_nat_gateway.natgw.id
}

output "public_ip_address" {
  description = "The public IP address of the NAT gateway."
  value       = azurerm_public_ip.natgw.ip_address
}
