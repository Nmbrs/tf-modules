resource "azurerm_resource_group" "main" {
  name     = local.resource_group_name
  location = var.location
  tags     = var.tags != null ? var.tags : {}

  lifecycle {
    ignore_changes = [tags]

    ## Naming validation: Ensure either override_name is provided OR workload is provided for automatic naming
    precondition {
      condition     = var.override_name != null || var.workload != null
      error_message = "Invalid naming configuration: Either 'override_name' must be provided, or 'workload' must be provided for automatic naming."
    }
  }
}
