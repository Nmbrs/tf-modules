resource "azurerm_app_service_certificate_order" "certificate" {
  name                = var.override_name != "" && var.override_name != null ? var.override_name : local.certificate_name
  resource_group_name = var.resource_group_name
  location            = "global"
  distinguished_name  = "CN=*.${var.domain_name}"
  product_type        = "WildCard"
  auto_renew          = true
  lifecycle {
    # validity_in_years is set by the issuing CA (CAB Forum SC-081v3 caps lifetimes;
    # 200 days from 2026-03-15, 100 from 2027-03-15, 47 from 2029-03-15) and the ARM
    # API reads it back as 0 after issuance, so any value here causes perpetual drift.
    ignore_changes = [tags, validity_in_years]
  }
}
