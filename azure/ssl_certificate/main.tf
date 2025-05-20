resource "azurerm_app_service_certificate_order" "certificate" {
  name                = var.override_name != "" && var.override_name != null ? var.override_name : local.certificate_name
  resource_group_name = var.resource_group_name
  location            = "global"
  distinguished_name  = "CN=*.${var.domain_name}"
  product_type        = "WildCard"
  auto_renew          = true
  validity_in_years   = 1
  lifecycle {
    ignore_changes = [tags]
  }
}
