resource "azurerm_role_assignment" "assignment" {
  scope                = local.resource_data_blocks[var.resource_type][0].id
  role_definition_name = var.roles[0]
  principal_id         = local.resource_data_blocks[var.principal_type][0].object_id
  principal_type       = local.principal_type[var.principal_type]
}
