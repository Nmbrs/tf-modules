locals {
  private_endpoint_name   = "pep-${var.resource_settings.name}"
  service_connection_name = "sc-${var.resource_settings.name}"
  resource_data_blocks = {
    app_service           = data.azurerm_windows_web_app.app_service,
    storage_account_blob  = data.azurerm_storage_account.storage_account_blob,
    storage_account_table = data.azurerm_storage_account.storage_account_table,
    storage_account_file  = data.azurerm_storage_account.storage_account_file,
    sql_server            = data.azurerm_mssql_server.sql_server,
    key_vault             = data.azurerm_key_vault.key_vault,
    service_bus           = data.azurerm_servicebus_namespace.service_bus,
    eventgrid_domain      = data.azurerm_eventgrid_domain.eventgrid_domain,
    eventgrid_topic       = data.azurerm_eventgrid_topic.eventgrid_topic,
    container_registry    = data.azurerm_container_registry.container_registry,
    cosmos_db_nosql       = data.azurerm_cosmosdb_account.cosmos_db_nosql,
    cosmos_db_mongodb     = data.azurerm_cosmosdb_account.cosmos_db_mongodb,
    redis_cache           = data.azurerm_redis_cache.redis_cache,
    api_management        = data.azurerm_api_management.api_management,
    app_configuration     = data.azurerm_app_configuration.app_configuration,
    # Add more resource types and corresponding data blocks as needed
  }

  # For more information on subresource names: https://learn.microsoft.com/en-us/azure/private-link/private-endpoint-overview
  subresource_name = {
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
    "cosmos_db_nosql"       = "SQL"
    "cosmos_db_mongodb"     = "MongoDB"
    "redis_cache"           = "redisCache"
    "api_management"        = "gateway"
    "app_configuration"     = "configurationStores"
  }
}
