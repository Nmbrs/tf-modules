resource "tfe_project" "project" {
  name         = var.name
  organization = var.organization_name
}

resource "tfe_project_variable_set" "association" {
  for_each        = toset(var.associated_variable_sets)
  variable_set_id = data.tfe_variable_set.variable_set[each.key].id
  project_id      = tfe_project.project.id
}
