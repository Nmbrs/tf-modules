resource "azurerm_resource_group" "app" {
  name     = "rg-${var.project}-${var.environment}"
  location = local.location

  tags = {
    country     = var.country
    environment = var.environment
    squad       = var.squad
    product     = var.product
  }
}

resource "azurerm_app_service_plan" "app" {
  name                = "asp-${var.project}-${var.environment}"
  location            = azurerm_resource_group.app.location
  resource_group_name = azurerm_resource_group.app.name
  kind                = "Windows"
  reserved            = false

  sku {
    tier = var.plan
    size = var.size
  }
}

resource "azurerm_app_service" "app" {
  name                    = "as-${var.project}-${var.environment}"
  location                = azurerm_resource_group.app.location
  resource_group_name     = azurerm_resource_group.app.name
  app_service_plan_id     = azurerm_app_service_plan.app.id
  https_only              = true
  enable_client_affinity  = true
  stack                   = var.stack
  identity {
    type = "SystemAssigned"
  }
  site_config = {
    always_on                 = true
    dotnet_framework_version  = var.dotnet_framework_version
    ftps_state                = "FtpsOnly"
    http2_enabled             = true
    managed_pipeline_mode     = "Integrated"
    use_32_bit_worker_process = false
    websockets_enabled        = false
    remote_debugging_enabled  = false
  }
}

resource "azurerm_log_analytics_workspace" "apm" {
  name                = "wsp-${var.project}-${var.environment}"
  location            = azurerm_resource_group.app.location
  resource_group_name = azurerm_resource_group.app.name  
  retention_in_days   = 90
}

resource "azurerm_application_insights" "apm" {  
  name                = "AppIns-${var.project}-${var.environment}-WebApp"
  location            = azurerm_resource_group.app.location
  resource_group_name = azurerm_resource_group.app.name
  workspace_id        = azurerm_log_analytics_workspace.apm .id
  application_type    = "web"

}