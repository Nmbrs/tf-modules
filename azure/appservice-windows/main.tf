resource "azurerm_app_service_plan" "app" {
  name                = "asp-${var.project}-${var.environment}"
  location            = var.location
  resource_group_name = var.resource_group
  kind                = "Windows"
  reserved            = false

  sku {
    tier = var.plan
    size = var.size
  }

  tags = merge(var.tags, local.auto_tags)
}

resource "azurerm_app_service" "app" {
  for_each            = var.apps
  name                = "as-${var.project}-${each.value["name"]}-${var.environment}"
  location            = var.location
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

  tags = merge(var.tags, local.auto_tags)
}

module "sslbinding" {
  source                              = "../../../tf-modules/azure/custom-domain-binding"
  apps                                = var.apps
  dns_zone_name                       = var.dns_zone_name
  dns_zone_resource_group             = var.dns_zone_resource_group
  ttl                                 = var.ttl
  resource_group                      = var.resource_group
  certificate_keyvault_name           = var.certificate_keyvault_name
  certificate_keyvault_resource_group = var.certificate_keyvault_resource_group
  certificate_name                    = var.certificate_name
  location                            = var.location
  tags                                = merge(var.tags, local.auto_tags)
  app_name                            = { for k, value in azurerm_app_service.app : k => value.name }
  app_default_site_hostname           = { for k, value in azurerm_app_service.app : k => value.default_site_hostname }
  depends_on = [
    azurerm_app_service.app
  ]
}

resource "azurerm_log_analytics_workspace" "app" {
  name                = "wsp-${var.project}-${var.environment}"
  location            = var.location
  resource_group_name = var.resource_group
  retention_in_days   = 90

  tags = merge(var.tags, local.auto_tags)
}

resource "azurerm_application_insights" "app" {
  name                = "appins-${var.project}-${var.environment}"
  location            = var.location
  resource_group_name = var.resource_group
  workspace_id        = azurerm_log_analytics_workspace.app.id
  application_type    = "web"

  tags = merge(var.tags, local.auto_tags)
}

resource "azurerm_app_service_virtual_network_swift_connection" "app" {
  for_each       = var.apps
  app_service_id = azurerm_app_service.app[each.value["name"]].id
  subnet_id      = each.value["subnet"]
}
