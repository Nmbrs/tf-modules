resource "azurerm_resource_group" "api" {
  name     = "rg-${var.organization}-${var.project}"
  location = local.location

  tags = "${var.tags}"
}

resource "azurerm_api_management" "api" {
  name                = "api-${var.organization}-${var.project}-${var.environment}"
  location            = local.location
  resource_group_name = azurerm_resource_group.api.name
  publisher_name      = var.squad_name
  publisher_email     = var.squad_email
  identity {
    type = "SystemAssigned"
  }
  sku_name = "Developer_1"

  tags = "${var.tags}"
}

resource "azurerm_storage_account" "api" {
  name                     = "sa${var.organization}${var.project}${var.environment}"
  resource_group_name      = azurerm_resource_group.api.name
  location                 = local.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = "${var.tags}"
}

resource "azurerm_storage_container" "api" {
  name                  = "${var.organization}${var.project}"
  storage_account_name  = azurerm_storage_account.api.name
  container_access_type = "private"
}

resource "azurerm_api_management_api" "api" {
  name                = "${var.service}"
  resource_group_name = azurerm_resource_group.api.name
  api_management_name = azurerm_api_management.api.name
  revision            = "1"
  display_name        = "${var.service}"
  path                = var.path
  protocols           = ["https"]
  service_url         = azurerm_api_management_backend.api.url
  import {
    content_format = "openapi+json"
    content_value  = var.openapi_specs
  }
}

resource "azurerm_api_management_api_policy" "api" {
  api_name            = azurerm_api_management_api.api.name
  api_management_name = azurerm_api_management.api.name
  resource_group_name = azurerm_resource_group.api.name
  xml_content = var.policy_payload
}

resource "azurerm_api_management_backend" "api" {
  name                = "api-${var.organization}-${var.project}"
  resource_group_name = azurerm_resource_group.api.name
  api_management_name = azurerm_api_management.api.name
  protocol            = "http"
  url                 = "${var.api_backend_url}"
}

resource "azurerm_api_management_product" "api" {
  product_id            = "test-product"
  api_management_name   = azurerm_api_management.api.name
  resource_group_name   = azurerm_resource_group.api.name
  display_name          = "Test Product"
  description           = "Test product with terraform"
  subscription_required = true
  published             = true
}

resource "azurerm_api_management_product_policy" "api" {
  product_id          = azurerm_api_management_product.api.product_id
  api_management_name = azurerm_api_management_product.api.api_management_name
  resource_group_name = azurerm_api_management_product.api.resource_group_name

  xml_content = var.policy_product

}

resource "azurerm_api_management_product_api" "api" {
  api_name            = azurerm_api_management_api.api.name
  product_id          = azurerm_api_management_product.api.product_id
  api_management_name = azurerm_api_management.api.name
  resource_group_name = azurerm_api_management.api.resource_group_name
  
}

data "azurerm_api_management_group" "api" {
  name                = "developers"
  api_management_name = azurerm_api_management.api.name
  resource_group_name = azurerm_api_management.api.resource_group_name
}

data "azurerm_api_management_group" "api2" {    
  name                = "guests"
  api_management_name = azurerm_api_management.api.name
  resource_group_name = azurerm_api_management.api.resource_group_name
}

resource "azurerm_api_management_product_group" "api" {
  product_id          = azurerm_api_management_product.api.product_id
  group_name          = data.azurerm_api_management_group.api.name
  api_management_name = azurerm_api_management.api.name
  resource_group_name = azurerm_api_management.api.resource_group_name
}

resource "azurerm_api_management_product_group" "api2" {
  product_id          = azurerm_api_management_product.api.product_id
  group_name          = data.azurerm_api_management_group.api2.name
  api_management_name = azurerm_api_management.api.name
  resource_group_name = azurerm_api_management.api.resource_group_name
}

resource "azurerm_api_management_named_value" "api" {
  name                = "api-apimg"
  resource_group_name = azurerm_resource_group.api.name
  api_management_name = azurerm_api_management.api.name
  display_name        = "ApiProperty"
  secret = true
  value_from_key_vault {
  secret_id = var.vault_id
  }
}