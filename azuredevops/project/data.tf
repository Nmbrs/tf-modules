
data "azuredevops_group" "aad_administrators" {
  name = lower(var.group_administrators)
}

data "azuredevops_group" "aad_contributors" {
  name = lower(var.group_contributors)
}

data "azuredevops_group" "aad_readers" {
  name = lower(var.group_readers)
}

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

data "azuredevops_group" "project_default_team" {
  project_id = azuredevops_project.project.id
  name       = "${azuredevops_project.project.name} Team"
}
