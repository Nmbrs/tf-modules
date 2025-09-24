resource "azurerm_mssql_server" "sql_server" {
  name                                 = var.override_name != "" && var.override_name != null ? var.override_name : local.sql_server_name
  resource_group_name                  = var.resource_group_name
  location                             = var.location
  version                              = "12.0"
  minimum_tls_version                  = "1.2"
  public_network_access_enabled        = var.network_settings.public_network_access_enabled
  outbound_network_restriction_enabled = false

  administrator_login          = var.local_sql_admin_user_settings.local_sql_admin_user
  administrator_login_password = data.azurerm_key_vault_secret.local_sql_admin_password.value

  azuread_administrator {
    azuread_authentication_only = var.azuread_authentication_only_enabled
    login_username              = var.azuread_sql_admin
    object_id                   = data.azuread_group.azuread_sql_admin.object_id
  }

  # Add identity to the SQL Server if local.audit_enabled
  dynamic "identity" {
    for_each = local.audit_enabled ? [1] : []
    content {
      type = "SystemAssigned"
    }
  }

  lifecycle {
    ignore_changes = [tags]
  }
}

resource "azurerm_mssql_virtual_network_rule" "sql_server_network_rule" {
  for_each = {
    for subnet in var.network_settings.allowed_subnets : subnet.subnet_name => subnet
    if var.network_settings.public_network_access_enabled
  }
  name                                 = each.key
  server_id                            = azurerm_mssql_server.sql_server.id
  subnet_id                            = data.azurerm_subnet.subnet[each.key].id
  ignore_missing_vnet_service_endpoint = false
}

# The feature "Allow acess to Azure services" can be achieved by setting the start_ip_address and end_ip_address to "0.0.0.0"
# For more information, see: https://learn.microsoft.com/en-us/rest/api/sql/firewall-rules/create-or-update

resource "azurerm_mssql_firewall_rule" "sql_server" {
  count            = var.network_settings.public_network_access_enabled && var.network_settings.trusted_services_bypass_firewall_enabled ? 1 : 0
  name             = "Allow_Azure_Trusted_Services"
  server_id        = azurerm_mssql_server.sql_server.id
  start_ip_address = "0.0.0.0"
  end_ip_address   = "0.0.0.0"

}

resource "azurerm_mssql_server_extended_auditing_policy" "sql_auditing" {
  count                                   = local.audit_enabled ? 1 : 0
  server_id                               = azurerm_mssql_server.sql_server.id
  storage_endpoint                        = data.azurerm_storage_account.auditing_storage_account[0].primary_blob_endpoint
  storage_account_access_key              = data.azurerm_storage_account.auditing_storage_account[0].primary_access_key
  storage_account_access_key_is_secondary = false
  retention_in_days                       = 7
}
