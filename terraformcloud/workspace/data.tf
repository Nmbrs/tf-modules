data "tfe_project" "project" {
  name         = var.associated_project
  organization = var.organization_name
}
