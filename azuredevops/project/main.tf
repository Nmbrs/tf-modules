# ==============================================================================
# Azure DevOps Project
# ==============================================================================
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
    artifacts    = "disabled"
  }

  lifecycle {
    ignore_changes = [description]
  }
}

# ==============================================================================
# Azure DevOps Pipelines - Environments
# ==============================================================================

# dev
resource "azuredevops_environment" "dev" {
  project_id = azuredevops_project.project.id
  name       = "dev"
}

# test
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

# production
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

# sandbox
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

# stage
resource "azuredevops_environment" "stage" {
  project_id = azuredevops_project.project.id
  name       = "stage"
}

resource "azuredevops_check_approval" "stage_environment" {
  project_id           = azuredevops_project.project.id
  target_resource_id   = azuredevops_environment.stage.id
  target_resource_type = "environment"

  requester_can_approve      = true
  minimum_required_approvers = 1
  approvers = [
    data.azuredevops_group.project_default_team.origin_id
  ]
  timeout = (24 * 60) * 14 #in minutes
}

# ==============================================================================
# Azure DevOps Project - Group Memberships
# ==============================================================================
resource "azuredevops_group_membership" "project_default_team_membership" {
  group = data.azuredevops_group.project_default_team.descriptor
  mode  = "add"
  members = [
    for group in data.azuredevops_group.aad_contributors : group.descriptor
  ]
}

resource "azuredevops_group_membership" "project_administrators" {
  group = data.azuredevops_group.project_administrators.descriptor
  mode  = "add"
  members = [
    for group in data.azuredevops_group.aad_administrators : group.descriptor
  ]
}

resource "azuredevops_group_membership" "readers" {
  group = data.azuredevops_group.readers.descriptor
  mode  = "add"
  members = [
    for group in data.azuredevops_group.aad_readers : group.descriptor
  ]
}

# # ==============================================================================
# # Azure DevOps Azure Service Connections  - Workload Identity Federation
# # ==============================================================================
# resource "azuredevops_serviceendpoint_azurerm" "azure_connection" {
#   for_each                               = { for azure_connection in var.service_connections.azure : azure_connection.name => azure_connection }
#   project_id                             = azuredevops_project.project.id
#   service_endpoint_name                  = each.value.name
#   description                            = "Azure Service conncetion managed by Terraform"
#   service_endpoint_authentication_scheme = "WorkloadIdentityFederation"
#   credentials {
#     serviceprincipalid = data.azurerm_user_assigned_identity[each.key].managed_identity.id
#   }
#   azurerm_spn_tenantid      = data.azurerm_subscription.current.tenant_id
#   azurerm_subscription_id   = data.azurerm_subscription.current.id
#   azurerm_subscription_name = data.azurerm_subscription.current.display_name
# }
