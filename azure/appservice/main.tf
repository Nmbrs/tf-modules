resource "azurerm_resource_group" "app" {
  name     = "rg-${var.organization}-${var.project}"
  location = local.location

  tags = {
    country     = var.country
    environment = var.environment
    squad       = var.owner
  }
}

resource "azurerm_app_service_plan" "app" {
  name                = var.service
  location            = azurerm_resource_group.app.location
  resource_group_name = azurerm_resource_group.app.name
  kind                = "Linux"

  sku {
    tier = var.plan
    size = var.size
  }

  tags = {
    country     = var.country
    environment = var.environment
    squad       = var.owner
  }
}

resource "azurerm_app_service" "app" {
  name                = "app-app-service"
  location            = azurerm_resource_group.app.location
  resource_group_name = azurerm_resource_group.app.name
  app_service_plan_id = azurerm_app_service_plan.app.id

  site_config {
    linux_fx_version = "DOTNETCORE|3.1"
  }

  tags = {
    country     = var.country
    environment = var.environment
    squad       = var.owner
  }
}

resource "azurerm_application_insights" "apm" {
  name                = "apm-${var.organization}-${var.project}"
  location            = azurerm_resource_group.app.location
  resource_group_name = azurerm_resource_group.app.name
  application_type    = var.app_type
}