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

data "azuredevops_group" "project_default_team" {
  project_id = azuredevops_project.project.id
  name       = "${azuredevops_project.project.name} Team"
}

resource "azuredevops_environment" "dev" {
  project_id = azuredevops_project.project.id
  name       = "dev"
}


resource "azuredevops_environment" "test" {
  project_id = azuredevops_project.project.id
  name       = "test"
}

resource "azuredevops_check_approval" "test_environment" {
  project_id           = azuredevops_project.project.id
  target_resource_id   = azuredevops_environment.test.id
  target_resource_type = "environment"

  requester_can_approve      = true
  minimum_required_approvers = 1
  approvers = [
    data.azuredevops_group.project_default_team.origin_id
  ]
  timeout = (24 * 60) * 14 #in minutes
}


resource "azuredevops_environment" "prod" {
  project_id = azuredevops_project.project.id
  name       = "prod"
}

resource "azuredevops_check_approval" "prod_environment" {
  project_id           = azuredevops_project.project.id
  target_resource_id   = azuredevops_environment.prod.id
  target_resource_type = "environment"

  requester_can_approve      = true
  minimum_required_approvers = 1
  approvers = [
    data.azuredevops_group.project_default_team.origin_id
  ]
  timeout = (24 * 60) * 14 #in minutes
}


resource "azuredevops_environment" "sand" {
  project_id = azuredevops_project.project.id
  name       = "sand"
}

resource "azuredevops_check_approval" "sand_environment" {
  project_id           = azuredevops_project.project.id
  target_resource_id   = azuredevops_environment.sand.id
  target_resource_type = "environment"

  requester_can_approve      = true
  minimum_required_approvers = 1
  approvers = [
    data.azuredevops_group.project_default_team.origin_id
  ]
  timeout = (24 * 60) * 14 #in minutes
}
