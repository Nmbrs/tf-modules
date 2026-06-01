resource "azurerm_application_insights" "main" {
  name                = local.app_insights_name
  location            = var.location
  resource_group_name = var.resource_group_name
  application_type    = var.application_type
  # workspace_id cannot be removed after set
  workspace_id                  = data.azurerm_log_analytics_workspace.workspace.id
  retention_in_days             = var.retention_in_days
  sampling_percentage           = 100
  local_authentication_disabled = false # local authentication needs to be enabled since disabling it requires code changes.
  internet_query_enabled        = true  # to set this parameter as false we need to enable the private links for azure_monitor
  internet_ingestion_enabled    = true  # to set this parameter as false we need to enable the private links for azure_monitor

  lifecycle {
    ignore_changes = [tags]

    precondition {
      condition     = var.override_name != null || var.workload != null
      error_message = "Invalid naming configuration: Either 'override_name' must be provided, or 'workload' must be provided for automatic naming."
    }
  }
}
