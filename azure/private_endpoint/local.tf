locals {
  private_endpoint_name = "pep-${var.workload}-${var.location}-${format("%03d", var.instance_count)}"
  resource_data_blocks = {
    app_service           = data.azurerm_windows_web_app.app_service,
    storage_account_blob  = data.azurerm_storage_account.storage_account_blob,
    storage_account_table = data.azurerm_storage_account.storage_account_table,
    storage_account_file  = data.azurerm_storage_account.storage_account_file,
    sql_server            = data.azurerm_mssql_server.sql_server,
    key_vault             = data.azurerm_key_vault.key_vault,
    service_bus           = data.azurerm_servicebus_namespace.service_bus
    eventgrid_domain      = data.azurerm_eventgrid_domain.eventgrid_domain,
    eventgrid_topic       = data.azurerm_eventgrid_topic.eventgrid_topic,
    container_registry    = data.azurerm_container_registry.container_registry,
    # Add more resource types and corresponding data blocks as needed
  }
  subresource_names = {
    "app_service"           = "sites"
    "storage_account_blob"  = "blob"
    "storage_account_table" = "table"
    "storage_account_file"  = "file"
    "sql_server"            = "sqlServer"
    "key_vault"             = "vault"
    "service_bus"           = "namespace"
    "eventgrid_domain"      = "domain"
    "eventgrid_topic"       = "topic"
    "container_registry"    = "registry"
  }

  private_dns_zones = {
    "app_service"           = "privatelink.azurewebsites.net"
    "storage_account_blob"  = "privatelink.blob.core.windows.net"
    "storage_account_table" = "privatelink.table.core.windows.net"
    "storage_account_file"  = "privatelink.file.core.windows.net"
    "sql_server"            = "privatelink.database.windows.net"
    "key_vault"             = "privatelink.vaultcore.azure.net"
    "service_bus"           = "privatelink.servicebus.windows.net	"
    "eventgrid_domain"      = "privatelink.eventgrid.azure.net"
    "eventgrid_topic"       = "privatelink.eventgrid.azure.net"
    "container_registry"    = "privatelink.azurecr.io"
  }
}