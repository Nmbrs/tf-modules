resource "azurerm_role_assignment" "assignment" {
  for_each = {
    for assignment in local.assignments : "${lower(assignment.resource_name)}_${replace(lower(assignment.role_name), " ", "-")}" => assignment
    if assignment.resource_type == "custom"
  }

  scope                = each.value.resource_id
  role_definition_name = each.value.role_name
  principal_id         = local.principal_data_blocks[var.principal_type][0].object_id
  principal_type       = local.principal_type[var.principal_type]
}
