resource "azurerm_log_analytics_workspace" "main" {
  name                       = local.workspace_name
  location                   = var.location
  resource_group_name        = var.resource_group_name
  sku                        = local.default_sku
  retention_in_days          = var.retention_in_days
  daily_quota_gb             = local.unlimited_daily_quota
  internet_ingestion_enabled = var.public_network_access_enabled
  internet_query_enabled     = var.public_network_access_enabled

  lifecycle {
    ignore_changes = [tags, sku, daily_quota_gb]
  }
}
