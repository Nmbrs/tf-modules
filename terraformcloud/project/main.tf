resource "tfe_project" "main" {
  name         = var.name
  organization = var.organization_name
}

resource "tfe_project_variable_set" "association" {
  for_each        = toset(var.associated_variable_sets)
  variable_set_id = data.tfe_variable_set.variable_set[each.key].id
  project_id      = tfe_project.main.id
}

resource "tfe_project_settings" "project" {
  project_id = tfe_project.main.id

  default_execution_mode = local.use_agent_pool ? "agent" : "remote"
  default_agent_pool_id  = local.use_agent_pool ? data.tfe_agent_pool.agent_pool[0].id : null
}
