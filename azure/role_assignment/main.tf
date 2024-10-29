resource "azurerm_role_assignment" "default_assignment" {
  for_each = {
    for assignment in local.assignments : "${lower(assignment.resource_name)}_${replace(lower(assignment.role_name), " ", "-")}" => assignment
    if assignment.resource_type != "custom"
  }
  scope                = local.resource_data_blocks[each.value.resource_type][each.value.resource_name].id
  role_definition_name = each.value.role_name
  principal_id         = local.principal_data_blocks[var.principal_type][0].object_id
  principal_type       = local.principal_type[var.principal_type]
}

resource "azurerm_role_assignment" "custom_assignment" {
  for_each = {
    for assignment in local.assignments : "${lower(split("/", assignment.id)[length(split("/", assignment.id)) - 1])}_${replace(lower(assignment.role_name), " ", "-")}" => assignment
    if assignment.resource_type == "custom"
  }
  scope                = each.value.resource_id
  role_definition_name = each.value.role_name
  principal_id         = local.principal_data_blocks[var.principal_type][0].object_id
  principal_type       = local.principal_type[var.principal_type]
}
