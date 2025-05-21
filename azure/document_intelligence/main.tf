resource "azurerm_cognitive_account" "document_intelligence" {
  kind                       = "FormRecognizer"
  location                   = var.location
  name                       = local.document_intelligence
  resource_group_name        = var.resource_group_name
  sku_name                   = "S0"
  custom_subdomain_name      = local.document_intelligence
  dynamic_throttling_enabled = var.autoscale_enabled
  network_acls {
    default_action = var.network_acls.default_action
    ip_rules       = var.network_acls.ip_rules
  }

  lifecycle {
    ignore_changes = [tags]
  }
}
