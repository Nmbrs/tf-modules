resource "azurerm_log_analytics_workspace" "workspace" {
  name                = local.workspace_name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = var.sku_name
  retention_in_days   = var.retention_in_days
  daily_quota_gb      = -1

  lifecycle {
    ignore_changes = [tags, daily_quota_gb]
  }
}
