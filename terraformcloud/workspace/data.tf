data "tfe_project" "project" {
  name         = var.associated_project_name
  organization = var.organization_name
}
