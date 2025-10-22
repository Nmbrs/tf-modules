output "name" {
  description = "The application gateway full name."
  value       = azurerm_application_gateway.main.name
}

output "workload" {
  description = "The application gateway workload name."
  value       = var.workload
}

output "id" {
  description = "The application gateway ID."
  value       = azurerm_application_gateway.main.id
}

output "public_ip_address" {
  description = "The public IP address of the application gateway."
  value       = azurerm_public_ip.application_gateway.ip_address
}

output "public_ip_fqdn" {
  description = "The public IP FQDN of the application gateway."
  value       = azurerm_public_ip.application_gateway.fqdn
}
