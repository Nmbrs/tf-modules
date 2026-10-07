# The local SQL admin password is generated once, at creation, only to guarantee a strong
# starting value. It is never output. The team resets it out-of-band (Azure Portal /
# az sql server update --admin-password) when the account is needed, and the lifecycle
# block on the server makes Terraform ignore any later change to it.
resource "random_password" "local_sql_admin" {
  length           = 32
  special          = true
  override_special = "!#%*()-_=+[]{}<>:?"
  min_upper        = 2
  min_lower        = 2
  min_numeric      = 2
  min_special      = 2
}

resource "azurerm_mssql_server" "main" {
  name                                 = local.sql_server_name
  resource_group_name                  = var.resource_group_name
  location                             = var.location
  version                              = "12.0"
  minimum_tls_version                  = "1.2"
  public_network_access_enabled        = var.firewall_settings.public_network_access_enabled
  outbound_network_restriction_enabled = false

  administrator_login          = var.admin_settings.local_username
  administrator_login_password = random_password.local_sql_admin.result

  azuread_administrator {
    azuread_authentication_only = var.admin_settings.azuread_authentication_only_enabled
    login_username              = var.admin_settings.azuread_group_name
    object_id                   = data.azuread_group.azuread_sql_admin.object_id
  }

  dynamic "identity" {
    for_each = local.auditing_enabled ? [1] : []
    content {
      type = "SystemAssigned"
    }
  }

  lifecycle {
    ignore_changes = [tags, administrator_login_password]

    ## Naming validation: Ensure either override_name is provided OR all required naming components are provided
    precondition {
      condition = var.override_name != null || (
        var.workload != null &&
        var.company_prefix != null
      )
      error_message = "Invalid naming configuration: Either 'override_name' must be provided, or both 'workload' and 'company_prefix' must be provided for automatic naming."
    }
  }
}

resource "azurerm_mssql_virtual_network_rule" "sql_server_network_rule" {
  for_each                             = local.vnet_rules
  name                                 = each.value.name
  server_id                            = azurerm_mssql_server.main.id
  subnet_id                            = each.value.subnet_id
  ignore_missing_vnet_service_endpoint = false
}

# The feature "Allow access to Azure services" can be achieved by setting the start_ip_address and end_ip_address to "0.0.0.0"
# For more information, see: https://learn.microsoft.com/en-us/rest/api/sql/firewall-rules/create-or-update

resource "azurerm_mssql_firewall_rule" "sql_server" {
  count            = var.firewall_settings.public_network_access_enabled && var.firewall_settings.trusted_services_bypass_firewall_enabled ? 1 : 0
  name             = "Allow_Azure_Trusted_Services"
  server_id        = azurerm_mssql_server.main.id
  start_ip_address = "0.0.0.0"
  end_ip_address   = "0.0.0.0"
}

resource "azurerm_mssql_server_extended_auditing_policy" "sql_auditing" {
  count                                   = local.auditing_enabled ? 1 : 0
  server_id                               = azurerm_mssql_server.main.id
  storage_endpoint                        = data.azurerm_storage_account.auditing_storage_account[0].primary_blob_endpoint
  storage_account_access_key              = data.azurerm_storage_account.auditing_storage_account[0].primary_access_key
  storage_account_access_key_is_secondary = false
  retention_in_days                       = 7
}
