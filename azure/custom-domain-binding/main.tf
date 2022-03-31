data "azurerm_dns_zone" "binding" {
  name                = var.dns_zone_name
  resource_group_name = var.dns_zone_resource_group
}

resource "azurerm_dns_cname_record" "binding" {
  for_each            = var.apps
  name                = each.value["cname"]
  zone_name           = data.azurerm_dns_zone.binding.name
  resource_group_name = data.azurerm_dns_zone.binding.resource_group_name
  ttl                 = var.ttl
  record              = var.app_default_site_hostname[each.key]
}

data "azurerm_app_service" "binding" {
  for_each            = var.app_name
  name                = each.value
  resource_group_name = var.resource_group
}

resource "azurerm_app_service_custom_hostname_binding" "binding" {
  for_each = {
    for key, value in var.apps : key => value
    if value.custom_domain != ""
  }
  hostname            = each.value["custom_domain"]
  app_service_name    = data.azurerm_app_service.binding[each.key].name
  resource_group_name = var.resource_group
  depends_on          = [azurerm_dns_cname_record.binding]

  lifecycle {
    ignore_changes = [thumbprint]
  }
}

data "azurerm_key_vault" "binding" {
  name                = var.certificate_keyvault_name
  resource_group_name = var.certificate_keyvault_resource_group
}

data "azurerm_key_vault_certificate" "binding" {
  name         = var.certificate_keyvault_name
  key_vault_id = data.azurerm_key_vault.binding.id
}

resource "azurerm_app_service_certificate" "binding" {
  for_each = {
    for key, value in var.apps : key => value
    if value.custom_domain != ""
  }
  name                = data.azurerm_key_vault_certificate.binding.name
  resource_group_name = var.resource_group
  location            = var.location
  key_vault_secret_id = data.azurerm_key_vault_certificate.binding.secret_id
}

resource "azurerm_app_service_certificate_binding" "binding" {
  for_each = {
    for key, value in var.apps : key => value
    if value.custom_domain != ""
  }
  hostname_binding_id = azurerm_app_service_custom_hostname_binding.binding[each.key].id
  certificate_id      = azurerm_app_service_certificate.binding[each.key].id
  ssl_state           = "SniEnabled"
}
