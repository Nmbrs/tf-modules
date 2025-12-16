data "azurerm_subnet" "subnet" {
  name                 = var.network_settings.subnet_name
  virtual_network_name = var.network_settings.vnet_name
  resource_group_name  = var.network_settings.vnet_resource_group_name
}

data "azurerm_windows_web_app" "app_service" {
  count               = var.resource_settings.type == "app_service" ? 1 : 0
  name                = var.resource_settings.name
  resource_group_name = var.resource_settings.resource_group_name
}

data "azurerm_storage_account" "storage_account_blob" {
  count               = var.resource_settings.type == "storage_account_blob" ? 1 : 0
  name                = var.resource_settings.name
  resource_group_name = var.resource_settings.resource_group_name
}

data "azurerm_storage_account" "storage_account_table" {
  count               = var.resource_settings.type == "storage_account_table" ? 1 : 0
  name                = var.resource_settings.name
  resource_group_name = var.resource_settings.resource_group_name
}

data "azurerm_storage_account" "storage_account_file" {
  count               = var.resource_settings.type == "storage_account_file" ? 1 : 0
  name                = var.resource_settings.name
  resource_group_name = var.resource_settings.resource_group_name
}

data "azurerm_mssql_server" "sql_server" {
  count               = var.resource_settings.type == "sql_server" ? 1 : 0
  name                = var.resource_settings.name
  resource_group_name = var.resource_settings.resource_group_name
}

data "azurerm_key_vault" "key_vault" {
  count               = var.resource_settings.type == "key_vault" ? 1 : 0
  name                = var.resource_settings.name
  resource_group_name = var.resource_settings.resource_group_name
}

data "azurerm_app_configuration" "app_configuration" {
  count               = var.resource_settings.type == "app_configuration" ? 1 : 0
  name                = var.resource_settings.name
  resource_group_name = var.resource_settings.resource_group_name
}

data "azurerm_servicebus_namespace" "service_bus" {
  count               = var.resource_settings.type == "service_bus" ? 1 : 0
  name                = var.resource_settings.name
  resource_group_name = var.resource_settings.resource_group_name
}

data "azurerm_eventgrid_domain" "eventgrid_domain" {
  count               = var.resource_settings.type == "eventgrid_domain" ? 1 : 0
  name                = var.resource_settings.name
  resource_group_name = var.resource_settings.resource_group_name
}

data "azurerm_eventgrid_topic" "eventgrid_topic" {
  count               = var.resource_settings.type == "eventgrid_topic" ? 1 : 0
  name                = var.resource_settings.name
  resource_group_name = var.resource_settings.resource_group_name
}

data "azurerm_container_registry" "container_registry" {
  count               = var.resource_settings.type == "container_registry" ? 1 : 0
  name                = var.resource_settings.name
  resource_group_name = var.resource_settings.resource_group_name
}

data "azurerm_cosmosdb_account" "cosmos_db_nosql" {
  count               = var.resource_settings.type == "cosmos_db_nosql" ? 1 : 0
  name                = var.resource_settings.name
  resource_group_name = var.resource_settings.resource_group_name
}

data "azurerm_cosmosdb_account" "cosmos_db_mongodb" {
  count               = var.resource_settings.type == "cosmos_db_mongodb" ? 1 : 0
  name                = var.resource_settings.name
  resource_group_name = var.resource_settings.resource_group_name
}

data "azurerm_redis_cache" "redis_cache" {
  count               = var.resource_settings.type == "redis_cache" ? 1 : 0
  name                = var.resource_settings.name
  resource_group_name = var.resource_settings.resource_group_name
}

data "azurerm_api_management" "api_management" {
  count               = var.resource_settings.type == "api_management" ? 1 : 0
  name                = var.resource_settings.name
  resource_group_name = var.resource_settings.resource_group_name
}

data "azurerm_container_registry" "azure_container_registry" {
  count               = var.resource_settings.type == "azure_container_registry" ? 1 : 0
  name                = var.resource_settings.name
  resource_group_name = var.resource_settings.resource_group_name
}

data "azurerm_data_factory" "datafactory" {
  count               = var.resource_settings.type == "datafactory" ? 1 : 0
  name                = var.resource_settings.name
  resource_group_name = var.resource_settings.resource_group_name
}

data "azurerm_data_factory" "datafactory_portal" {
  count               = var.resource_settings.type == "datafactory_portal" ? 1 : 0
  name                = var.resource_settings.name
  resource_group_name = var.resource_settings.resource_group_name
}
