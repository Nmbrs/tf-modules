locals {
  private_endpoint_name = "pep-${var.private_endpoint_name}-${var.environment}-${var.location}-${format("%03d", var.instance_count)}"

  resource_data_blocks = {
    app_service     = data.azurerm_windows_web_app.app_service,
    storage_account = data.azurerm_storage_account.storage_account,
    sql_server      = data.azurerm_mssql_server.sql_server,
    key_vault       = data.azurerm_key_vault.key_vault,
    # Add more resource types and corresponding data blocks as needed
  }
  subresource_names = {
    "app_service"      = "sites"
    "storage_account"  = "blob"
    "sql_server"       = "sqlServer"
    "key_vault"        = "vault"
    "eventgrid_domain" = "domain"
    "eventgrid_topic"  = "topic"
  }

  private_dns_zones = {
    "app_service"      = "privatelink.azurewebsites.net"
    "storage_account"  = "privatelink.blob.core.windows.net"
    "sql_server"       = "privatelink.database.windows.net"
    "key_vault"        = "privatelink.vaultcore.azure.net"
    "eventgrid_domain" = "privatelink.eventgrid.azure.net"
    "eventgrid_topic"  = "privatelink.eventgrid.azure.net"
  }
}
