output "id" {
  description = "The ID of the metric alert"
  value       = azurerm_monitor_metric_alert.this.id
}

output "name" {
  description = "The name of the metric alert"
  value       = azurerm_monitor_metric_alert.this.name
}
