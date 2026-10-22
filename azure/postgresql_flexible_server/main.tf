# The local administrator password is generated once, at creation, only to guarantee a
# strong starting value. It is never output. The team resets it out-of-band (Azure Portal /
# az postgres flexible-server update --admin-password) when the account is needed, and the
# lifecycle block on the server makes Terraform ignore any later change to it.
# It only exists in hybrid mode: when Entra ID is the only authentication method (the default)
# there is no local administrator and no password at all.
resource "random_password" "local_admin" {
  count            = local.local_admin_enabled ? 1 : 0
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
  auto_grow_enabled             = var.auto_grow_enabled
  zone                          = var.zone
  backup_retention_days         = var.backup_settings.retention_days
  geo_redundant_backup_enabled  = var.backup_settings.geo_redundant_enabled
  public_network_access_enabled = var.public_network_access_enabled

  # The local administrator only exists in hybrid mode. Azure does not return the login once
  # password authentication is turned off, so it must be null (not just unused) in Entra-only mode.
  administrator_login    = local.local_admin_enabled ? var.admin_settings.local_username : null
  administrator_password = one(random_password.local_admin[*].result)

  authentication {
    active_directory_auth_enabled = true
    password_auth_enabled         = local.local_admin_enabled
    tenant_id                     = data.azurerm_client_config.current.tenant_id
  }

  # Maintenance schedule (UTC)
  maintenance_window {
    day_of_week  = 6 # Saturday
    start_hour   = 23
    start_minute = 0
  }

  dynamic "high_availability" {
    for_each = var.high_availability_mode == null ? [] : [var.high_availability_mode]
    content {
      mode = high_availability.value
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
      auto_grow_enabled,
      # A fail-over swaps the primary and standby zones.
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

    ## Name length validation: the private endpoint name is derived from the server name
    precondition {
      condition     = local.server_name_length <= local.max_server_name_length
      error_message = format("Invalid server name '%s' (%d characters): it must have at most %d characters so that the private endpoint name 'pep-<name>-%s' stays within Azure's 80 character limit. Shorten 'workload' or 'override_name'.", local.postgresql_flexible_server_name == null ? "" : local.postgresql_flexible_server_name, local.server_name_length, local.max_server_name_length, lower(local.private_endpoint_subresources[0]))
    }

    ## high_availability validation
    precondition {
      condition     = var.high_availability_mode == null || !local.burstable_sku
      error_message = format("Invalid configuration: 'high_availability_mode' is not supported with the Burstable SKU '%s', use a 'GP_' or 'MO_' SKU.", var.sku_name)
    }
  }
}

resource "azurerm_postgresql_flexible_server_active_directory_administrator" "main" {
  server_name         = azurerm_postgresql_flexible_server.main.name
  resource_group_name = azurerm_postgresql_flexible_server.main.resource_group_name
  tenant_id           = data.azurerm_client_config.current.tenant_id
  object_id           = data.azuread_group.azuread_pgsql_admin.object_id
  principal_name      = var.admin_settings.azuread_group_name
  principal_type      = "Group"
}
