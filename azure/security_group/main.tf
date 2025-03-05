resource "azuread_group" "security_group" {
  display_name     = var.name
  owners           = [data.azuread_client_config.current.object_id]
  security_enabled = true
  types            = var.dynamic_membership_enabled ? ["DynamicMembership"] : []

  dynamic "dynamic_membership" {
    for_each = var.dynamic_membership_enabled ? [1] : []
    content {
      enabled = true
      rule    = var.dynamic_membership_rule
    }
  }
}
