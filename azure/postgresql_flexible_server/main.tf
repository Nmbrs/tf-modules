# The local PostgreSQL admin password is generated once, at creation, only to guarantee a strong
# starting value. It is never output. The team resets it out-of-band (Azure Portal /
# az postgres flexible-server update --admin-password) when the account is needed, and the
# lifecycle block on the server makes Terraform ignore any later change to it.
# It only exists when password authentication is enabled: in Entra-only mode (the default)
# there is no local administrator and no password at all.
resource "random_password" "local_psql_admin" {
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
  name                = local.postgresql_server_name
  resource_group_name = var.resource_group_name
  location            = var.location

  version           = var.postgresql_version
  sku_name          = var.sku_name
  storage_mb        = var.storage_mb
  auto_grow_enabled = true
  zone              = var.zone

  backup_retention_days        = var.backup_settings.retention_days
  geo_redundant_backup_enabled = var.backup_settings.geo_redundant_enabled

  # Connectivity is the private endpoint provisioned in private_endpoint.tf, like every other
  # data-tier module. No VNet integration, so no delegated_subnet_id / private_dns_zone_id.
  public_network_access_enabled = var.public_network_access_enabled

  # The local administrator only exists when password authentication is enabled.
  administrator_login    = local.local_admin_enabled ? var.admin_settings.local_username : null
  administrator_password = one(random_password.local_psql_admin[*].result)

  authentication {
    active_directory_auth_enabled = true
    password_auth_enabled         = local.local_admin_enabled
    tenant_id                     = data.azurerm_client_config.current.tenant_id
  }

  dynamic "high_availability" {
    for_each = var.high_availability_mode == null ? [] : [var.high_availability_mode]
    content {
      mode = high_availability.value
    }
  }

  # Maintenance schedule: Saturday 23:00 UTC, the same slot as the other data-tier modules.
  maintenance_window {
    day_of_week  = 6
    start_hour   = 23
    start_minute = 0
  }

  lifecycle {
    # Azure swaps the primary and standby zones on failover; without ignoring them the next plan
    # would try to move the server back.
    ignore_changes = [tags, administrator_password, zone, high_availability[0].standby_availability_zone]

    ## Naming validation: Ensure either override_name is provided OR all required naming components are provided
    precondition {
      condition = var.override_name != null || (
        var.workload != null &&
        var.company_prefix != null
      )
      error_message = "Invalid naming configuration: Either 'override_name' must be provided, or both 'workload' and 'company_prefix' must be provided for automatic naming."
    }

    ## High availability validation: Burstable SKUs do not support high availability
    precondition {
      condition     = var.high_availability_mode == null || !local.burstable_sku
      error_message = format("Invalid value '%s' for variable 'high_availability_mode' when using the Burstable SKU '%s', high availability requires a General Purpose (GP_) or Memory Optimized (MO_) SKU.", coalesce(var.high_availability_mode, "null"), var.sku_name)
    }
  }
}

resource "azurerm_postgresql_flexible_server_active_directory_administrator" "main" {
  server_name         = azurerm_postgresql_flexible_server.main.name
  resource_group_name = azurerm_postgresql_flexible_server.main.resource_group_name
  tenant_id           = data.azurerm_client_config.current.tenant_id
  object_id           = data.azuread_group.azuread_psql_admin.object_id
  principal_name      = var.admin_settings.azuread_group_name
  principal_type      = "Group"
}
