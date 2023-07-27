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
  for_each = { for app in var.app_services : app.name => app }

  name                = "as-${var.service_plan_name}-${each.value.name}-${var.environment}"
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
  for_each = { for app in var.app_services : app.name => app }

  app_service_id = azurerm_windows_web_app.web_app[each.value.name].id
  subnet_id      = data.azurerm_subnet.service_plan.id
}


## Custom domain binding
data "azurerm_dns_zone" "dns" {
  for_each = { for custom_domain in local.custom_domains : custom_domain.fqdn => custom_domain }

  name                = each.value.dns_zone_name
  resource_group_name = each.value.dns_zone_resource_group
}

resource "azurerm_dns_txt_record" "domain_verification" {
  for_each = { for custom_domain in local.custom_domains : "asuid.${custom_domain.fqdn}" => custom_domain }

  name                = "asuid.${each.value.cname_record_name}"
  zone_name           = each.value.dns_zone_name
  resource_group_name = each.value.dns_zone_resource_group
  ttl                 = 30

  record {
    value = azurerm_windows_web_app.web_app[each.value.app_short_name].custom_domain_verification_id
  }
}

resource "azurerm_app_service_custom_hostname_binding" "custom_domain" {
  for_each = { for custom_domain in local.custom_domains : custom_domain.fqdn => custom_domain }

  hostname            = each.value.fqdn
  app_service_name    = each.value.app_full_name
  resource_group_name = data.azurerm_resource_group.service_plan.name

  lifecycle {
    ignore_changes = [thumbprint]
  }

  depends_on = [azurerm_dns_txt_record.domain_verification]
}




data "azurerm_key_vault" "certificate" {
  for_each = { for custom_domain in local.custom_domains : custom_domain.fqdn => custom_domain }

  name                = each.value.key_vault_name
  resource_group_name = "RG-KeyVault"
  # !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
}

data "azurerm_key_vault_secret" "certificate" {
  for_each = { for custom_domain in local.custom_domains : custom_domain.fqdn => custom_domain }

  name         = each.value.key_vault_secret_name
  key_vault_id = data.azurerm_key_vault.certificate[each.key].id
}

resource "azurerm_app_service_certificate" "certificate" {
  # !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
  ## Needs to be fixed because the values are hardcoded
  # for_each = { for custom_domain in local.custom_domains : custom_domain.fqdn => custom_domain }
  
  # name         = each.value.key_vault_secret_name
  # name                = each.value.fqdn
  name                = "wildcard-nmbrsapp-test-com03459ea8-97f1-49f8-83af-676e04547166"
  resource_group_name = data.azurerm_resource_group.service_plan.name
  location            = data.azurerm_resource_group.service_plan.location
  key_vault_secret_id = "https://kv-nmbrs-general-test.vault.azure.net/secrets/wildcard-nmbrsapp-test-com03459ea8-97f1-49f8-83af-676e04547166/55c9f50e8d4e424ab8f85803614bda64"
  # key_vault_secret_id = data.azurerm_key_vault_secret.certificate[each.key].id
  # key_vault_secret_id = data.azurerm_key_vault_certificate.certificate_binding[each.key].secret_id

  lifecycle {
    ignore_changes = [tags]
  }
}

resource "azurerm_app_service_certificate_binding" "certificate_binding" {
  ## !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
  for_each = { for custom_domain in local.custom_domains : custom_domain.fqdn => custom_domain }

  hostname_binding_id = azurerm_app_service_custom_hostname_binding.custom_domain[each.key].id
  # certificate_id      = azurerm_app_service_certificate.certificate[each.key].id
  certificate_id      = azurerm_app_service_certificate.certificate.id
  ssl_state           = "SniEnabled"
}
