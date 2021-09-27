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
    product     = var.product
  }
}

resource "azurerm_app_service" "app" {
  name                = "as-${var.project}-${var.environment}"
  location            = azurerm_resource_group.app.location
  resource_group_name = azurerm_resource_group.app.name
  app_service_plan_id = azurerm_app_service_plan.app.id

  site_config {
    linux_fx_version = "DOTNETCORE|3.1"
  }

  identity {
    type = "SystemAssigned"
  }

  tags = {
    country     = var.country
    environment = var.environment
    squad       = var.squad
    product     = var.product
  }
}

resource "azurerm_log_analytics_workspace" "apm" {
  name                = "wsp-${var.project}-${var.environment}"
  location            = azurerm_resource_group.app.location
  resource_group_name = azurerm_resource_group.app.name  
  retention_in_days   = 90

  tags = {
    country     = var.country
    environment = var.environment
    squad       = var.squad
    product     = var.product
  }

}

resource "azurerm_application_insights" "apm" {  
  name                = "apm-${var.project}-${var.environment}"
  location            = azurerm_resource_group.app.location
  resource_group_name = azurerm_resource_group.app.name
  workspace_id        = azurerm_log_analytics_workspace.apm .id
  application_type    = "web"

  tags = {
    country     = var.country
    environment = var.environment
    squad       = var.squad
    product     = var.product
  }
}