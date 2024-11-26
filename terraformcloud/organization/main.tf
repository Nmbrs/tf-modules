resource "tfe_organization" "organization" {
  name                          = each.value.name
  email                         = each.value.admin_email
  allow_force_delete_workspaces = true
  collaborator_auth_policy      = "two_factor_mandatory"
}
