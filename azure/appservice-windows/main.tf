resource "azurerm_app_service_plan" "app" {
  name                = "asp-${var.project}-${var.environment}"
  location            = local.location
  resource_group_name = var.resource_group
  kind                = "Windows"
  reserved            = false

  sku {
    tier = var.plan
    size = var.size
  }
}

resource "azurerm_app_service" "app" {
  name                    = "as-${var.project}-${var.environment}"
  location                = local.location
  resource_group_name     = var.resource_group
  app_service_plan_id     = azurerm_app_service_plan.app.id
  https_only              = true
  enable_client_affinity  = true
  stack                   = ".net"
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

resource "azurerm_log_analytics_workspace" "app" {
  name                = "wsp-${var.project}-${var.environment}"
  location            = local.location
  resource_group_name = var.resource_group  
  retention_in_days   = 90
}

resource "azurerm_application_insights" "app" {  
  name                = "appins-${var.project}-${var.environment}"
  location            = local.location
  resource_group_name = var.resource_group
  workspace_id        = azurerm_log_analytics_workspace.apm .id
  application_type    = "web"

}