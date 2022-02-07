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

  tags = var.tags
}

resource "azurerm_app_service" "app" {
  name                = "as-${var.project}-${var.environment}"
  location            = local.location
  resource_group_name = var.resource_group
  app_service_plan_id = azurerm_app_service_plan.app.id
  https_only          = true

  identity {
    type = "SystemAssigned"
  }

  site_config {
    always_on                 = true
    dotnet_framework_version  = var.dotnetVersion
    ftps_state                = "FtpsOnly"
    http2_enabled             = true
    managed_pipeline_mode     = "Integrated"
    use_32_bit_worker_process = false
    websockets_enabled        = false
    remote_debugging_enabled  = false
  }

  tags = var.tags
}

resource "azurerm_log_analytics_workspace" "app" {
  name                = "wsp-${var.project}-${var.environment}"
  location            = local.location
  resource_group_name = var.resource_group
  retention_in_days   = 90

  tags = var.tags
}

resource "azurerm_application_insights" "app" {
  name                = "appins-${var.project}-${var.environment}"
  location            = local.location
  resource_group_name = var.resource_group
  workspace_id        = azurerm_log_analytics_workspace.app.id
  application_type    = "web"

  tags = var.tags

}

resource "azurerm_app_service_virtual_network_swift_connection" "app" {
  app_service_id = azurerm_app_service.app.id
  subnet_id      = var.vnet_subnet_id
}