resource "azurerm_mssql_server" "sql_server" {
  name                = local.sql_server_name
  resource_group_name = var.resource_group_name
  location            = var.location
  version             = "12.0"
  minimum_tls_version = "1.2"

  azuread_administrator {
    azuread_authentication_only = true
    login_username              = var.sql_admin
    object_id                   = data.azuread_group.sql_admin.object_id
  }

  lifecycle {
    ignore_changes = [tags]
  }
}

resource "azurerm_mssql_virtual_network_rule" "sql_server_network_rule" {
  name      = var.subnet_name
  server_id = azurerm_mssql_server.sql_server.id
  subnet_id = data.azurerm_subnet.subnet.id
}