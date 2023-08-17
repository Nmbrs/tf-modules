data "azurerm_dns_zone" "binding" {
  name                = var.dns_zone_name
  resource_group_name = var.dns_zone_resource_group
}

resource "azurerm_dns_txt_record" "domain_verification" {
  for_each = { for custom_domain in local.custom_domains : "asuid.${custom_domain.fqdn}" => custom_domain }

  name                = "asuid.${each.value.fqdn}"
  zone_name           = each.value.dns_zone_name
  resource_group_name = each.value.dns_zone_resource_group
  ttl                 = 30

  record {
    value = azurerm_windows_web_app.web_app[each.value.app_short_name].custom_domain_verification_id
  }
}

resource "azurerm_dns_cname_record" "binding" {
  for_each            = var.apps
  name                = var.cname_record_name
  zone_name           = data.azurerm_dns_zone.binding.name
  resource_group_name = data.azurerm_dns_zone.binding.resource_group_name
  ttl                 = var.cname_record_ttl
  record              = var.app_default_site_hostname[each.key]

  lifecycle {
    ignore_changes = [tags]
  }
}

data "azurerm_windows_web_app" "binding" {
  for_each            = var.app_name
  name                = each.value
  resource_group_name = var.resource_group_name
}

data "azurerm_resource_group" "binding" {
  name = var.resource_group_name
}

resource "azurerm_app_service_custom_hostname_binding" "binding" {
  for_each = {
    for key, value in var.apps : key => value
    if value.custom_domain != ""
  }
  hostname            = each.value["custom_domain"]
  app_service_name    = data.azurerm_windows_web_app.binding[each.key].name
  resource_group_name = data.azurerm_resource_group.binding.name
  depends_on          = [azurerm_dns_cname_record.binding]

  lifecycle {
    ignore_changes = [thumbprint]
  }
}

data "azurerm_app_service_certificate" "binding" {
  name                = "example-app-service-certificate"
  resource_group_name = "example-rg"
}

data "azurerm_key_vault" "binding" {
  name                = var.certificate_keyvault_name
  resource_group_name = var.certificate_keyvault_resource_group
}

data "azurerm_key_vault_certificate" "binding" {
  name         = var.certificate_name
  key_vault_id = data.azurerm_key_vault.binding.id
}

resource "azurerm_app_service_certificate" "binding" {
  name                = data.azurerm_key_vault_certificate.binding.name
  resource_group_name = data.azurerm_resource_group.binding.name
  location            = data.azurerm_resource_group.binding.location
  key_vault_secret_id = data.azurerm_key_vault_certificate.binding.secret_id
  depends_on = [
    azurerm_app_service_custom_hostname_binding.binding
  ]

  lifecycle {
    ignore_changes = [tags]
  }
}

resource "azurerm_app_service_certificate_binding" "binding" {
  for_each = {
    for key, value in var.apps : key => value
    if value.custom_domain != ""
  }
  hostname_binding_id = azurerm_app_service_custom_hostname_binding.binding[each.key].id
  certificate_id      = azurerm_app_service_certificate.binding.id
  ssl_state           = "SniEnabled"
  depends_on = [
    azurerm_app_service_certificate.binding
  ]
}
