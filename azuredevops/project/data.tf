
data "azuredevops_group" "aad_administrators" {
  for_each = toset([for group in var.administrators_groups: lower(group)])
  name     = each.value
}

data "azuredevops_group" "aad_contributors" {
  for_each = toset([for group in var.contributors_groups: lower(group)])
  name     = each.value
}

data "azuredevops_group" "aad_readers" {
  for_each = toset([for group in var.readers_groups: lower(group)])
  name     = each.value
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
