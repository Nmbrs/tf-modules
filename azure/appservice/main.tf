resource "azurerm_app_service_plan" "app" {
  name                = "asp-${var.project}-${var.environment}"
  location            = azurerm_resource_group.app.location
  resource_group_name = var.resource_group
  kind                = "Linux"
  reserved = true

  sku {
    tier = var.plan
    size = var.size
  }
}

resource "azurerm_app_service" "app" {
  name                = "as-${var.project}-${var.environment}"
  location            = azurerm_resource_group.app.location
  resource_group_name = var.resource_group
  app_service_plan_id = azurerm_app_service_plan.app.id
  https_only = true

  identity {
    type = "SystemAssigned"
  }
}

resource "azurerm_log_analytics_workspace" "app" {
  name                = "wsp-${var.project}-${var.environment}"
  location            = azurerm_resource_group.app.location
  resource_group_name = var.resource_group
  retention_in_days   = 90
}

resource "azurerm_application_insights" "app" {  
  name                = "apm-${var.project}-${var.environment}"
  location            = azurerm_resource_group.app.location
  resource_group_name = var.resource_group
  workspace_id        = azurerm_log_analytics_workspace.app .id
  application_type    = "web"
}