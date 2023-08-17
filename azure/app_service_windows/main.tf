## Data Read - Resource Group
data "azurerm_resource_group" "service_plan" {
  name = var.resource_group_name
}

## App Service plan
resource "azurerm_service_plan" "service_plan" {
  name                = "asp-${var.service_plan_name}-${var.environment}"
  resource_group_name = data.azurerm_resource_group.service_plan.name
  location            = data.azurerm_resource_group.service_plan.location
  os_type             = var.os_type
  sku_name            = var.sku_name

  lifecycle {
    ignore_changes = [tags]
  }
}

## Logging
resource "azurerm_log_analytics_workspace" "service_plan" {
  name                = "wsp-${var.service_plan_name}-${var.environment}"
  resource_group_name = data.azurerm_resource_group.service_plan.name
  location            = data.azurerm_resource_group.service_plan.location
  retention_in_days   = 90

  lifecycle {
    ignore_changes = [tags]
  }
}

resource "azurerm_application_insights" "service_plan" {
  name                = "appins-${var.service_plan_name}-${var.environment}"
  resource_group_name = data.azurerm_resource_group.service_plan.name
  location            = data.azurerm_resource_group.service_plan.location
  workspace_id        = azurerm_log_analytics_workspace.service_plan.id
  application_type    = "web"

  lifecycle {
    ignore_changes = [tags]
  }
}

## App Service
resource "azurerm_windows_web_app" "web_app" {
  for_each = toset(var.app_service_names)

  name                = "as-${var.service_plan_name}-${each.key}-${var.environment}"
  resource_group_name = data.azurerm_resource_group.service_plan.name
  location            = data.azurerm_resource_group.service_plan.location
  service_plan_id     = azurerm_service_plan.service_plan.id
  https_only          = true

  identity {
    type = "SystemAssigned"
  }


  site_config {
    always_on                = true
    minimum_tls_version      = "1.2"
    ftps_state               = "FtpsOnly"
    http2_enabled            = true
    managed_pipeline_mode    = "Integrated"
    use_32_bit_worker        = false
    websockets_enabled       = false
    remote_debugging_enabled = false
    load_balancing_mode      = var.load_balancing_mode
    vnet_route_all_enabled   = true

    application_stack {
      current_stack  = var.stack
      dotnet_version = var.dotnet_version
    }
  }

  lifecycle {
    ignore_changes = [tags, virtual_network_subnet_id]
  }
}

## VNET integration
data "azurerm_subnet" "service_plan" {
  name                 = var.network_settings.subnet_name
  virtual_network_name = var.network_settings.vnet_name
  resource_group_name  = var.network_settings.vnet_resource_group_name
}

resource "azurerm_app_service_virtual_network_swift_connection" "web_app" {
  for_each = toset(var.app_service_names)

  app_service_id = azurerm_windows_web_app.web_app[each.key].id
  subnet_id      = data.azurerm_subnet.service_plan.id
}