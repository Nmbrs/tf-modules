# data "azurerm_user_assigned_identity" "managed_identity" {
#   count               = var.principal_type == "managed_identity" ? 1 : 0
#   name                = "example-identity"
#   resource_group_name = "example-rg"
# }

data "azuread_service_principal" "managed_identity" {
  count        = var.principal_type == "managed_identity" ? 1 : 0
  display_name = var.principal_name
}

data "azuread_service_principal" "service_principal" {
  count        = var.principal_type == "service_principal" ? 1 : 0
  display_name = var.principal_name
}

data "azuread_group" "security_group" {

  count        = var.principal_type == "security_group" ? 1 : 0
  display_name = var.principal_name
}

data "azuread_user" "user" {
  count               = var.principal_type == "user" ? 1 : 0
  user_principal_name = var.principal_name
}

data "azurerm_resource_group" "resource_group" {
  count = var.resource_type == "resource_group" ? 1 : 0
  name  = var.resource_name
}