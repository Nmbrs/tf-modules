data "azuread_group" "azuread_pgsql_admin" {
  display_name     = var.admin_settings.azuread_group_name
  security_enabled = true
}

data "azurerm_client_config" "current" {}
