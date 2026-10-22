# The local administrator password is generated once, at creation, only to guarantee a
# strong starting value. It is never output. The team resets it out-of-band (Azure Portal /
# az postgres flexible-server update --admin-password) when the account is needed, and the
# lifecycle block on the server makes Terraform ignore any later change to it.
resource "random_password" "local_admin" {
  length           = 32
  special          = true
  override_special = "!#%*()-_=+[]{}<>:?"
  min_upper        = 2
  min_lower        = 2
  min_numeric      = 2
  min_special      = 2
}

resource "azurerm_postgresql_flexible_server" "main" {
  name                          = local.postgresql_flexible_server_name
  resource_group_name           = var.resource_group_name
  location                      = var.location
  version                       = var.postgresql_version
  sku_name                      = var.sku_name
  storage_mb                    = var.storage_mb
  storage_tier                  = var.storage_tier
  auto_grow_enabled             = var.auto_grow_enabled
  zone                          = var.zone
  backup_retention_days         = var.backup_retention_days
  geo_redundant_backup_enabled  = var.geo_redundant_backup_enabled
  public_network_access_enabled = var.public_network_access_enabled

  administrator_login    = var.admin_settings.local_username
  administrator_password = random_password.local_admin.result

  # Maintenance schedule (UTC)
  maintenance_window {
    day_of_week  = 6 # Saturday
    start_hour   = 23
    start_minute = 0
  }

  dynamic "high_availability" {
    for_each = var.high_availability == null ? [] : [var.high_availability]
    content {
      mode                      = high_availability.value.mode
      standby_availability_zone = high_availability.value.standby_availability_zone
    }
  }

  lifecycle {
    ignore_changes = [
      tags,
      administrator_password,
      # Operational parameters: only applied at creation and changed out-of-band afterwards.
      # A changed version would force a new server, so major upgrades are done out-of-band.
      version,
      sku_name,
      storage_mb,
      storage_tier,
      # A fail-over moves the primary to the standby zone.
      zone,
      high_availability[0].standby_availability_zone,
    ]

    ## Naming validation: Ensure either override_name is provided OR all required naming components are provided
    precondition {
      condition = var.override_name != null || (
        var.workload != null &&
        var.company_prefix != null
      )
      error_message = "Invalid naming configuration: Either 'override_name' must be provided, or both 'workload' and 'company_prefix' must be provided for automatic naming."
    }

    ## high_availability validation
    precondition {
      condition     = var.high_availability == null || !startswith(var.sku_name, "B_")
      error_message = format("Invalid configuration: 'high_availability' is not supported with the Burstable SKU '%s', use a 'GP_' or 'MO_' SKU.", var.sku_name)
    }

    precondition {
      condition     = try(var.high_availability.standby_availability_zone == null || var.zone == null || var.high_availability.standby_availability_zone != var.zone, true)
      error_message = "Invalid configuration: 'high_availability.standby_availability_zone' must differ from 'zone'."
    }
  }
}
