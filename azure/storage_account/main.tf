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
    bypass         = var.trusted_services_bypass_firewall_enabled ? ["AzureServices", "Logging", "Metrics"] : ["None"]
    default_action = "Deny"

    ip_rules                   = []
    virtual_network_subnet_ids = []
  }

  lifecycle {
    ignore_changes = [tags]

    ## Naming validation: Ensure either override_name is provided OR all naming components are provided
    precondition {
      condition = var.override_name != null || (
        var.workload != null &&
        var.company_prefix != null
      )
      error_message = "Invalid naming configuration: Either 'override_name' must be provided, or both 'workload' and 'company_prefix' must be provided for automatic naming."
    }
  }

}
