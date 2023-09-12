data "azurerm_log_analytics_workspace" "workspace" {
  name                = var.workspace_name
  resource_group_name = var.workspace_resource_group_name
}

resource "azurerm_application_insights" "insights" {
  name                          = local.app_insights_name
  location                      = var.location
  resource_group_name           = var.resource_group_name
  application_type              = var.application_type
  workspace_id                  = data.azurerm_log_analytics_workspace.workspace.id
  retention_in_days             = var.retention_in_days
  sampling_percentage           = 100
  local_authentication_disabled = false # local authenticaton needs to be enable since disabling it requires code changes.
  internet_query_enabled        = true  # to set this parameters as false we need to enable the private links for azure_monitor
  internet_ingestion_enabled    = true  # to set this parameters as false we need to enable the private links for azure_monitor

  lifecycle {
    ignore_changes = [tags]
  }
}
