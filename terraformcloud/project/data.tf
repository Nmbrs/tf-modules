
data "tfe_variable_set" "variable_set" {
  for_each     = toset(var.associated_variable_sets)
  name         = each.key
  organization = var.organization_name
}

data "tfe_agent_pool" "agent_pool" {
  count        = local.use_agent_pool ? 1 : 0
  name         = var.associated_agent_pool
  organization = var.organization_name
}
