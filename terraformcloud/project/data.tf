
data "tfe_variable_set" "variable_set" {
  for_each     = toset(var.associated_variable_sets)
  name         = each.key
  organization = var.organization_name
}
