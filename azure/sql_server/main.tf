resource "azurerm_mssql_server" "sql_server" {
  name                = local.sql_server_name
  resource_group_name = var.resource_group_name
  location            = var.location
  version             = "12.0"
  minimum_tls_version = "1.2"
  administrator_login = var.local_sql_admin != "" ? var.local_sql_admin : null
  administrator_login_password = var.local_sql_admin_password != "" ? data.azurerm_key_vault_secret.local_sql_admin_password[0].value : null

  azuread_administrator {
    azuread_authentication_only = var.local_sql_admin_password != "" ? false : true
    login_username              = var.sql_admin
    object_id                   = data.azuread_group.sql_admin.object_id
  }

  lifecycle {
    ignore_changes = [tags]
  }
}

resource "azurerm_mssql_virtual_network_rule" "sql_server_network_rule" {
  for_each  = { for subnet in var.allowed_subnets : subnet.subnet_name => subnet }
  name      = each.key
  server_id = azurerm_mssql_server.sql_server.id
  subnet_id = data.azurerm_subnet.subnet[each.key].id
}

resource "azurerm_mssql_server_extended_auditing_policy" "sql_auditing" {
  server_id                               = azurerm_mssql_server.sql_server.id
  storage_endpoint                        = data.azurerm_storage_account.auditing_storage_account.primary_blob_endpoint
  storage_account_access_key              = data.azurerm_storage_account.auditing_storage_account.primary_access_key
  storage_account_access_key_is_secondary = false
  retention_in_days                       = 7
}