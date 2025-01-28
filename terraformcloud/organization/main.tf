resource "tfe_organization" "organization" {
  name                                = var.name
  email                               = var.admin_email
  allow_force_delete_workspaces       = true
  collaborator_auth_policy            = "two_factor_mandatory"
  speculative_plan_management_enabled = false
}
