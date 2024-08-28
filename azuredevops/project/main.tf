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


# #########################################################
# # Permissions
# #########################################################




data "azuredevops_group" "aad_administrators" {
  name = lower(var.group_administrators)
}

data "azuredevops_group" "aad_contributors" {
  name = lower(var.group_contributors)
}

data "azuredevops_group" "aad_readers" {
  name = lower(var.group_readers)
}


# # # ####
# # # # ADO Groups
# # # ###


data "azuredevops_group" "contributors" {
  project_id = azuredevops_project.project.id
  name       = "Contributors"
}

data "azuredevops_group" "project_administrators" {
  project_id = azuredevops_project.project.id
  name       = "Project Administrators"
}

data "azuredevops_group" "readers" {
  project_id = azuredevops_project.project.id
  name       = "Readers"
}

resource "azuredevops_group_membership" "project_default_team_membership" {
  group = data.azuredevops_group.project_default_team.descriptor
  mode  = "add"
  members = [
    data.azuredevops_group.aad_contributors.descriptor
  ]
}

# resource "azuredevops_group_membership" "contributors" {
#   for_each = { for project in var.projects : trimspace(lower(project.name)) => project }
#   group = data.azuredevops_group.contributors[each.value.name].descriptor
#   mode  = "overwrite"
#   members = [
#     data.azuredevops_group.project_default_team[each.value.name].descriptor
#   ]
# }

resource "azuredevops_group_membership" "project_administrators" {
  group = data.azuredevops_group.project_administrators.descriptor
  mode  = "add"
  members = [
    data.azuredevops_group.aad_administrators.descriptor
  ]
}

resource "azuredevops_group_membership" "readers" {
  group = data.azuredevops_group.readers.descriptor
  mode  = "add"
  members = [
    data.azuredevops_group.aad_readers.descriptor
  ]
}
