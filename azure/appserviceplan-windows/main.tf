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