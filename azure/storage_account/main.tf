resource "azurerm_storage_account" "storage_account" {
  name                       = local.storage_account_name
  resource_group_name        = var.resource_group_name
  location                   = var.location
  account_kind               = var.account_kind
  account_tier               = var.account_tier
  account_replication_type   = var.replication_type
  https_traffic_only_enabled = true
  min_tls_version            = "TLS1_2"

  lifecycle {
    ignore_changes = [tags]
  }
}
