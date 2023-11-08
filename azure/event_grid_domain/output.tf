output "name" {
  description = "The event grid domain full name."
  value       = azurerm_eventgrid_domain.domain.name
}

output "workload" {
  description = "The event grid domain workload name."
  value       = var.workload
}

output "id" {
  description = "The event grid domain ID."
  value       = azurerm_eventgrid_domain.domain.id
}

output "endpoint" {
  description = "The endpoint associated with the event grid domain."
  value       = azurerm_eventgrid_domain.domain.endpoint
}

output "primary_access_key" {
  description = "The primary access key associated with the event grid domain."
  value       = azurerm_eventgrid_domain.domain.primary_access_key
  sensitive   = true
}

output "secondary_access_key" {
  description = "The second access key associated with the event grid domain."
  value       = azurerm_eventgrid_domain.domain.secondary_access_key
  sensitive   = true
}

