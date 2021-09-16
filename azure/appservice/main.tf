resource "azurerm_resource_group" "app" {
  name     = "rg-${var.organization}-${var.project}"
  location = local.location

  tags = {
    country     = var.description
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
    tier = var.sku_tier
    size = var.sku_size
  }

  tags = {
    country     = var.description
    environment = var.environment
    squad       = var.owner
  }
}

resource "azurerm_app_service" "app" {
  name                = "app-app-service"
  location            = azurerm_resource_group.app.location
  resource_group_name = azurerm_resource_group.app.name
  app_service_plan_id = azurerm_app_service_plan.app.id

  tags = {
    country     = var.description
    environment = var.environment
    squad       = var.owner
  }
}
