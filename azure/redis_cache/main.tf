resource "azurerm_redis_cache" "main" {
  name                          = local.redis_cache_name
  location                      = var.location
  resource_group_name           = var.resource_group_name
  capacity                      = var.sku_name == "Premium" ? local.premium_tier_capacity[var.cache_size_in_gb] : local.basic_standard_tier_capacity[var.cache_size_in_gb]
  redis_version                 = 6
  family                        = var.sku_name == "Premium" ? "P" : "C"
  sku_name                      = var.sku_name
  non_ssl_port_enabled          = false
  minimum_tls_version           = "1.2"
  public_network_access_enabled = var.public_network_access_enabled
  zones                         = []
  tenant_settings               = {}

  shard_count = var.sku_name == "Premium" ? var.shard_count : 0 # Sharding is only supported in the "Premium" tier

  redis_configuration {
    authentication_enabled = true
    # This needs to be refactored after being solved in newer versions of the azurerm provider
    # For more information see: https://github.com/hashicorp/terraform-provider-azurerm/pull/22309
    aof_backup_enabled = var.sku_name == "Premium" ? false : null
    rdb_backup_enabled = false
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

    ## Naming validation: Ensure either override_name is provided OR all naming components are provided
    precondition {
      condition = var.override_name != null || (
        var.workload != null &&
        var.company_prefix != null &&
        var.sequence_number != null
      )
      error_message = "Invalid naming configuration: Either 'override_name' must be provided, or all of 'workload', 'company_prefix', and 'sequence_number' must be provided for automatic naming."
    }

    ## cache_size_in_gb validation
    precondition {
      condition     = (var.sku_name == "Basic" && contains([0.25, 1, 2.5, 6, 13, 26, 53], var.cache_size_in_gb)) || var.sku_name == "Standard" || var.sku_name == "Premium"
      error_message = format("Invalid value '%s' for variable 'cache_size_in_gb' when using the 'Basic' SKU, valid options are 0.25, 1, 2.5, 6, 13, 26, 53.", var.cache_size_in_gb)
    }

    precondition {
      condition     = (var.sku_name == "Standard" && contains([0.25, 1, 2.5, 6, 13, 26, 53], var.cache_size_in_gb)) || var.sku_name == "Basic" || var.sku_name == "Premium"
      error_message = format("Invalid value '%s' for variable 'cache_size_in_gb' when using the 'Standard' SKU, valid options are 0.25, 1, 2.5, 6, 13, 26, 53.", var.cache_size_in_gb)
    }

    precondition {
      condition     = (var.sku_name == "Premium" && contains([6, 13, 26, 53, 120], var.cache_size_in_gb)) || var.sku_name == "Basic" || var.sku_name == "Standard"
      error_message = format("Invalid value '%s' for variable 'cache_size_in_gb' when using the 'Premium' SKU, valid options are 6, 13, 26, 53, 120.", var.cache_size_in_gb)
    }


    ## shard_count validation
    precondition {
      condition     = (var.sku_name == "Basic" && var.shard_count == 0) || var.sku_name == "Standard" || var.sku_name == "Premium"
      error_message = format("Invalid value '%s' for variable 'shard_count' when using the 'Basic' SKU, it must be 0.", var.shard_count)
    }

    precondition {
      condition     = (var.sku_name == "Standard" && var.shard_count == 0) || var.sku_name == "Basic" || var.sku_name == "Premium"
      error_message = format("Invalid value '%s' for variable 'shard_count' when using the 'Standard' SKU, it must be 0.", var.shard_count)
    }
  }
}
