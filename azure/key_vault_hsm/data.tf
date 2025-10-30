data "azurerm_client_config" "current" {}

# Fetch Azure AD security groups that will have admin access to the HSM
data "azuread_group" "admin_groups" {
  for_each = toset([for group in var.admin_group_names : lower(group)])

  display_name     = each.value
  security_enabled = true
}
