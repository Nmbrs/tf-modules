resource "azuread_group" "security_group" {
  display_name     = var.name
  owners           = [data.azuread_client_config.current.object_id]
  security_enabled = true
}
