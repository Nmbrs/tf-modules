output "name" {
  description = "The container app environment full name."
  value       = azurerm_container_app_environment.environment.name
}

output "workload" {
  description = "The application gateway workload name."
  value       = var.workload
}

output "id" {
  description = "The application gateway  gateway  ID."
  value       = azurerm_container_app_environment.environment.id
}

output "reserved_cidr" {
  value       = azurerm_container_app_environment.environment.platform_reserved_cidr
  description = "Output of the public IP address"
}

output "reserved_dns_ip_address" {
  value       = azurerm_container_app_environment.environment.platform_reserved_dns_ip_address
  description = "Output of the public IP FQDN"
}