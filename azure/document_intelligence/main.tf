resource "azurerm_cognitive_account" "document_intelligence" {
  kind                = "FormRecognizer"
  location            = var.location
  name                = local.document_intelligence
  resource_group_name = var.resource_group_name
  sku_name            = "S0"
}
