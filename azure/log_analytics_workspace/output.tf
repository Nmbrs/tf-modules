output "name" {
  value       = azurerm_log_analytics_workspace.workspace.name
  description = "The log analytics workspace name."
}

output "id" {
  value       = azurerm_log_analytics_workspace.workspace.id
  description = "The Log Analytics Workspace ID."
}

output "workspace_id" {
  value       = azurerm_log_analytics_workspace.workspace.id
  description = "The Workspace (or Customer) ID for the Log Analytics Workspace."
}

output "primary_shared_key" {
  description = "The Primary shared key for the Log Analytics Workspace."
  value       = azurerm_log_analytics_workspace.workspace.primary_shared_key
  sensitive   = true
}

output "secondary_shared_key" {
  description = "The Secondary shared key for the Log Analytics Workspace."
  value       = azurerm_log_analytics_workspace.workspace.secondary_shared_key
  sensitive   = true
}
