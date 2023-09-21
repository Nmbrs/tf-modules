locals {
  resource_data_blocks = {
    app_service     = data.azurerm_windows_web_app.app_service,
    storage_account = data.azurerm_storage_account.storage_account,
    sql_server      = data.azurerm_mssql_server.sql_server,
    # Add more resource types and corresponding data blocks as needed
  }
  subresource_names = {
    "app_service"     = "sites"
    "storage_account" = "blob"
    "sql_server"      = "sqlServer"
  }
}

