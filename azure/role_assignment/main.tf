resource "azurerm_role_assignment" "assignment" {
  for_each           = toset(var.roles)
  scope              = local.resource_data_blocks[var.resource_type][0].id
  role_definition_name = each.value
  #role_definition_id = data.azurerm_role_definition.role_definition[each.value].id
  principal_id       = local.principal_data_blocks[var.principal_type][0].object_id
  principal_type     = local.principal_type[var.principal_type]
}
