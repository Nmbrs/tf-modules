output "id" {
  description = "Redis ID."
  value       = azurerm_redis_cache.redis.id
}

output "name" {
  description = "The name of the Redis Instance."
  value       = azurerm_redis_cache.redis.name
}

output "hostname" {
  description = "The Hostname of the Redis Instance."
  value       = azurerm_redis_cache.redis.hostname
}

output "ssl_port" {
  description = "ssl_port - The SSL Port of the Redis Instance."
  value       = azurerm_redis_cache.redis.ssl_port
}

output "non_ssl_port" {
  description = "The non-SSL Port of the Redis Instance."
  value       = azurerm_redis_cache.redis.port
}

output "primary_connection_string" {
  description = "The primary connection string of the Redis Instance."
  value       = azurerm_redis_cache.redis.primary_connection_string
  sensitive   = true
}

output "secondary_connection_string" {
  description = "The primary connection string of the Redis Instance."
  value       = azurerm_redis_cache.redis.secondary_connection_string
  sensitive   = true
}

output "primary_access_key" {
  description = "The primary access key for  the Redis Instance."
  value       = azurerm_redis_cache.redis.primary_access_key
  sensitive   = true
}

output "secondary_access_key" {
  description = "The secondary access key for  the Redis Instance."
  value       = azurerm_redis_cache.redis.secondary_access_key
  sensitive   = true
}
