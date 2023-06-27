data "azurerm_client_config" "current" {}

data "azurerm_resource_group" "redis_rg" {
  name = var.resource_group_name
}

resource "azurerm_redis_cache" "redis" {
  name                          = "redis-${var.name}-${var.environment}"
  location                      = data.azurerm_resource_group.redis_rg.location
  resource_group_name           = data.azurerm_resource_group.redis_rg.name
  capacity                      = local.premium_tier_capacity[var.cache_size_gb]
  redis_version                 = 6
  family                        = "P"
  sku_name                      = "Premium"
  enable_non_ssl_port           = false
  minimum_tls_version           = "1.2"
  public_network_access_enabled = true
  zones                         = []
  tenant_settings               = {}

  shard_count = var.shard_count

  redis_configuration {
    enable_authentication = true
    aof_backup_enabled    = false
    rdb_backup_enabled    = false
    # Removes the least recently used key out of all the keys with an expiration set.
    maxmemory_policy = "volatile-lru"
  }

  # Maintenance schedule
  patch_schedule {
    day_of_week        = "Saturday"
    start_hour_utc     = 23
    maintenance_window = "PT5H"
  }

  lifecycle {
    ignore_changes = [tags]
  }
}
