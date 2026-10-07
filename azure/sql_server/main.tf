# The local SQL admin password is generated once, at creation, purely to guarantee a
# strong starting value. It is deliberately never stored or surfaced: rotation happens
# out-of-band (Azure Portal / az sql server update --admin-password) whenever the account
# is actually needed. Terraform cannot drift on it because the Azure API never returns
# the admin password, so no lifecycle block is required to keep external resets.
resource "random_password" "local_sql_admin" {
  length           = 32
  special          = true
  override_special = "!#%*()-_=+[]{}<>:?"
  min_upper        = 2
  min_lower        = 2
  min_numeric      = 2
  min_special      = 2
}

resource "azurerm_mssql_server" "sql_server" {
  name                                 = var.override_name != "" && var.override_name != null ? var.override_name : local.sql_server_name
  resource_group_name                  = var.resource_group_name
  location                             = var.location
  version                              = "12.0"
  minimum_tls_version                  = "1.2"
  administrator_login                  = var.local_sql_admin
  administrator_login_password         = random_password.local_sql_admin.result
  public_network_access_enabled        = var.public_network_settings.access_enabled
  outbound_network_restriction_enabled = false

  azuread_administrator {
    azuread_authentication_only = var.azuread_authentication_only_enabled
    login_username              = var.azuread_sql_admin
    object_id                   = data.azuread_group.azuread_sql_admin.object_id
  }

  lifecycle {
    ignore_changes = [tags]
  }
}

resource "azurerm_mssql_virtual_network_rule" "sql_server_network_rule" {
  for_each = {
    for subnet in var.public_network_settings.allowed_subnets : subnet.subnet_name => subnet
    if var.public_network_settings.access_enabled
  }
  name                                 = each.key
  server_id                            = azurerm_mssql_server.sql_server.id
  subnet_id                            = data.azurerm_subnet.subnet[each.key].id
  ignore_missing_vnet_service_endpoint = false
}

resource "azurerm_mssql_server_extended_auditing_policy" "sql_auditing" {
  count                                   = local.audit_enabled ? 1 : 0
  server_id                               = azurerm_mssql_server.sql_server.id
  storage_endpoint                        = data.azurerm_storage_account.auditing_storage_account[0].primary_blob_endpoint
  storage_account_access_key              = data.azurerm_storage_account.auditing_storage_account[0].primary_access_key
  storage_account_access_key_is_secondary = false
  retention_in_days                       = 7
}
