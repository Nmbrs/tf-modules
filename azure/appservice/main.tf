resource "azurerm_resource_group" "app" {
  name     = "rg-${var.project}"
  location = local.location

  tags = {
    country     = var.country
    environment = var.environment
    squad       = var.squad
  }
}

resource "azurerm_app_service_plan" "app" {
  name                = "asp-${var.project}"
  location            = azurerm_resource_group.app.location
  resource_group_name = azurerm_resource_group.app.name
  kind                = "Linux"
  reserved = true

  sku {
    tier = var.plan
    size = var.size
  }

  tags = {
    country     = var.country
    environment = var.environment
    squad       = var.squad
  }
}

resource "azurerm_app_service" "app" {
  name                = "as-${var.project}"
  location            = azurerm_resource_group.app.location
  resource_group_name = azurerm_resource_group.app.name
  app_service_plan_id = azurerm_app_service_plan.app.id

  site_config {
    linux_fx_version = "DOTNETCORE|3.1"
  }

  tags = {
    country     = var.country
    environment = var.environment
    squad       = var.squad
  }
}

resource "azurerm_log_analytics_workspace" "apm" {
  name                = "wsp-${var.project}"
  location            = azurerm_resource_group.app.location
  resource_group_name = azurerm_resource_group.app.name
  sku                 = "Premium"
  retention_in_days   = 90
}

resource "azurerm_application_insights" "apm" {  
  name                = "apm-${var.project}"
  location            = azurerm_resource_group.app.location
  resource_group_name = azurerm_resource_group.app.name
  workspace_id        = azurerm_log_analytics_workspace.apm.id
  application_type    = "web"
}