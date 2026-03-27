data "azurerm_log_analytics_workspace" "workspace" {
  name                = var.workspace_settings.name
  resource_group_name = var.workspace_settings.resource_group_name
}
