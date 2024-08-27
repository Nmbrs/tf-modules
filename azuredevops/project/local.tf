resource "azuredevops_project" "project" {
  name               = var.name
  visibility         = "private"
  version_control    = "Git"
  work_item_template = "Agile"
  description        = "Managed by Terraform"
  features = {
    boards       = "disabled"
    repositories = "disabled"
    pipelines    = "enabled"
    testplans    = "disabled"
    artifacts    = "enabled"
  }

  lifecycle {
    ignore_changes = [description]
  }
}