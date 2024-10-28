resource "azurerm_role_assignment" "assignment" {
  for_each             = { for assignment in local.assignments : "${assignment.resource_name}_${assignment.role_name}" => assignment }
  scope                = local.resource_data_blocks[each.value.resource_type][each.value.resource_name].id
  role_definition_name = each.value.role_name
  principal_id         = local.principal_data_blocks[var.principal_type][0].object_id
  principal_type       = local.principal_type[var.principal_type]
}
