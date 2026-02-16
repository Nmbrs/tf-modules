output "name" {
  description = "The name of the Redis Instance."
  value       = azurerm_redis_cache.main.name
}

output "workload" {
  description = "The redis instance workload name."
  value       = var.workload
}

output "id" {
  description = "The Redis ID."
  value       = azurerm_redis_cache.main.id
}

output "hostname" {
  description = "The Hostname of the Redis Instance."
  value       = azurerm_redis_cache.main.hostname
}

output "ssl_port" {
  description = "The SSL Port of the Redis Instance."
  value       = azurerm_redis_cache.main.ssl_port
}

output "non_ssl_port" {
  description = "The non-SSL Port of the Redis Instance."
  value       = azurerm_redis_cache.main.port
}

output "primary_connection_string" {
  description = "The primary connection string of the Redis Instance."
  value       = azurerm_redis_cache.main.primary_connection_string
  sensitive   = true
}

output "secondary_connection_string" {
  description = "The secondary connection string of the Redis Instance."
  value       = azurerm_redis_cache.main.secondary_connection_string
  sensitive   = true
}

output "primary_access_key" {
  description = "The primary access key for the Redis Instance."
  value       = azurerm_redis_cache.main.primary_access_key
  sensitive   = true
}

output "secondary_access_key" {
  description = "The secondary access key for the Redis Instance."
  value       = azurerm_redis_cache.main.secondary_access_key
  sensitive   = true
}
