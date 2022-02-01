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

resource "azurerm_virtual_network" "app" {
  name                = "vnet-${var.project}-${var.environment}"
  location            = local.location
  resource_group_name = var.resource_group
  address_space       =  ["172.22.0.0/16"]
}
resource "azurerm_subnet" "app" {
  name                 = "snet-${var.project}-${var.environment}"
  resource_group_name  = var.resource_group
  virtual_network_name = azurerm_virtual_network.app.name
  address_prefixes     = ["172.22.0.0/24"]

  delegation {
    name = "snet-delegation"

    service_delegation {
      name    = "Microsoft.Web/serverFarms"
      actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
    }
  }
}

resource "azurerm_app_service" "app" {
  name                    = "as-${var.project}-${var.environment}"
  location                = local.location
  resource_group_name     = var.resource_group
  app_service_plan_id     = azurerm_app_service_plan.app.id
  https_only              = true
  
  identity {
    type = "SystemAssigned"
  }
  
  site_config {
    always_on                 = true
    #virtual_network_name      = "${azurerm_virtual_network.vnet.name}"
    dotnet_framework_version  = var.dotnetVersion
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
  workspace_id        = azurerm_log_analytics_workspace.app.id
  application_type    = "web"

}

resource "azurerm_app_service_virtual_network_swift_connection" "app" {
  app_service_id = azurerm_app_service.app.id
  subnet_id      = azurerm_subnet.app.id
}