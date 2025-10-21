locals {
  # Log Analytics Workspace name: Must be unique within resource group
  # Format: wsp-{company}-{workload}-{env}-{location}-{seq}
  workspace_name = (var.override_name != null ?
    lower(var.override_name) :
    lower("log-${var.company_prefix}-${var.workload}-${var.environment}-${var.location}-${format("%03d", var.sequence_number)}")
  )
}

locals {
  # Log Analytics Workspace constants
  # Retention period limits (in days)
  min_retention_days = 30
  max_retention_days = 730

  # Default retention period
  default_retention_days = 90

  # Daily quota constants
  unlimited_daily_quota = -1

  # SKU options
  default_sku = "PerGB2018"
}
