resource "tfe_workspace" "workspace" {
  name                = var.name
  organization        = var.organization_name
  terraform_version   = "~>1.5.0"
  project_id          = data.tfe_project.project.id
  force_delete        = false
  queue_all_runs      = false
  speculative_enabled = true
}
