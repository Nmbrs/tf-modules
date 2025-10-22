output "name" {
  value       = azurerm_log_analytics_workspace.main.name
  description = "The log analytics workspace name."
}

output "workload" {
  description = "The log analytics workspace workload name."
  value       = var.workload
}

output "id" {
  value       = azurerm_log_analytics_workspace.main.id
  description = "The Log Analytics Workspace ID."
}

output "workspace_id" {
  value       = azurerm_log_analytics_workspace.main.id
  description = "The Workspace (or Customer) ID for the Log Analytics Workspace."
}

output "primary_shared_key" {
  description = "The Primary shared key for the Log Analytics Workspace."
  value       = azurerm_log_analytics_workspace.main.primary_shared_key
  sensitive   = true
}

output "secondary_shared_key" {
  description = "The Secondary shared key for the Log Analytics Workspace."
  value       = azurerm_log_analytics_workspace.main.secondary_shared_key
  sensitive   = true
}
