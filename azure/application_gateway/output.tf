output "name" {
  description = "The application gateway full name."
  value       = azurerm_application_gateway.app_gw.name
}

output "workload" {
  description = "The application gateway workload name."
  value       = var.workload
}

output "id" {
  description = "The application gateway  gateway  ID."
  value       = azurerm_application_gateway.app_gw.id
}

output "public_ip_address" {
  value       = azurerm_public_ip.app_gw.ip_address
  description = "Output of the public IP address"
}

output "public_ip_fqdn" {
  value       = azurerm_public_ip.app_gw.fqdn
  description = "Output of the public IP FQDN"
}