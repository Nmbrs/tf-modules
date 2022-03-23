resource "azurerm_storage_account" "storage_account" {
  name                      = lower(var.name)
  resource_group_name       = var.resource_group_name
  location                  = var.location
  account_kind              = var.account_kind
  account_tier              = var.account_tier
  account_replication_type  = var.replication_type
  enable_https_traffic_only = true
  min_tls_version           = "TLS1_2"

  tags = merge(var.tags, local.default_tags)

  queue_properties {
    logging {
      delete                = true
      read                  = true
      write                 = true
      version               = "1.0"
      retention_policy_days = 10
    }
    hour_metrics {
      enabled               = true
      include_apis          = true
      retention_policy_days = 7
      version               = "1.0"
    }
    minute_metrics {
      enabled               = false
      include_apis          = false
      retention_policy_days = 10
      version               = "1.0"
    }
  }
}
