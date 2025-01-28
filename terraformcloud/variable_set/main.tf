resource "tfe_variable_set" "variable_sets" {
  name         = var.name
  description  = var.description
  organization = var.organization_name
  priority     = false
  global       = false
}
