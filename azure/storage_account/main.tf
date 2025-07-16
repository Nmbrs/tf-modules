resource "azurerm_storage_account" "storage_account" {
  name                            = local.storage_account_name
  resource_group_name             = var.resource_group_name
  location                        = var.location
  account_kind                    = var.account_kind
  account_tier                    = var.sku_name
  account_replication_type        = var.replication_type
  https_traffic_only_enabled      = true
  min_tls_version                 = "TLS1_2"
  public_network_access_enabled   = var.public_network_access_enabled
  allow_nested_items_to_be_public = var.public_network_access_enabled

  network_rules {
    default_action             = "Deny"
    bypass                     = ["None"]
    ip_rules                   = []
    virtual_network_subnet_ids = []
  }

  lifecycle {
    ignore_changes = [tags]
  }

}
