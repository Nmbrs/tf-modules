data "azurerm_client_config" "current" {}

data "azurerm_resource_group" "rg" {
  name = var.resource_group_name
}

resource "azurerm_cosmosdb_account" "cosmo_db" {
  access_key_metadata_writes_enabled = true
  analytical_storage_enabled         = false
  default_identity_type              = "FirstPartyIdentity"
  enable_automatic_failover          = false
  enable_free_tier                   = false
  enable_multiple_write_locations    = false
  is_virtual_network_filter_enabled  = false
  kind                               = var.kind 
  local_authentication_disabled      = false
  mongo_server_version                  = var.mongo_db_version 
  name                                  = var.name             
  network_acl_bypass_for_azure_services = false
  network_acl_bypass_ids                = []
  offer_type                            = "Standard"
  public_network_access_enabled         = true
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
  tags = merge(data.azurerm_resource_group.rg.tags, local.default_tags, var.extra_tags)

  backup {
    interval_in_minutes = 240
    retention_in_hours  = 8
    storage_redundancy  = "Geo"
    type                = "Periodic"
  }

  consistency_policy {
    consistency_level       = "Session"
    max_interval_in_seconds = 5
    max_staleness_prefix    = 100
  }

  geo_location {
    failover_priority = 0
    location          = data.azurerm_resource_group.rg.location
    zone_redundant    = false
  }
}
