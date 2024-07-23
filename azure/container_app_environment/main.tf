
# resource "azurerm_container_app_environment_certificate" "example" {
#   name                         = "myfriendlyname"
#   container_app_environment_id = azurerm_container_app_environment.example.id
#   certificate_blob_base64      = filebase64("path/to/certificate_file.pfx")
#   certificate_password         = ""
# }
data "azurerm_resource_group" "environment" {
  name = var.resource_group_name

}
resource "azurerm_container_app_environment" "environment" {
  name                       = local.container_app_environment_name
  location                   = var.location
  resource_group_name        = var.resource_group_name
  log_analytics_workspace_id = data.azurerm_log_analytics_workspace.workspace.id
  infrastructure_subnet_id   = data.azurerm_subnet.container_app_environment.id

  // Default Consumption Workload Profile as presented in the UI
  workload_profile {
    name                  = "Consumption"
    workload_profile_type = "Consumption"
    maximum_count         = 0
    minimum_count         = 0
  }

  internal_load_balancer_enabled = true

  timeouts {
    create = "60m"
    update = "60m"
    delete = "30m"
  }

  lifecycle {
    ignore_changes = [tags]
  }
}


resource "azapi_update_resource" "managed_identity_settings" {
  type      = "Microsoft.App/managedEnvironments@2024-03-01"
  name      = local.container_app_environment_name
  # location  = var.location
  parent_id = data.azurerm_resource_group.environment.id
  # identity {
  #   type         = "string"
  #   identity_ids = [data.azurerm_user_assigned_identity.identity.id]
  # }

  body = {
    identity = {
      type = "UserAssigned"
      userAssignedIdentities = {
        "${data.azurerm_user_assigned_identity.identity.id}" = {}
      }
    }
  }

  depends_on = [azurerm_container_app_environment.environment]
}


resource "azurerm_container_app_environment_storage" "file_share" {
  for_each                     = { for file_share in var.file_share_settings : file_share.name => file_share }
  name                         = lower(each.value.name)
  container_app_environment_id = azurerm_container_app_environment.environment.id
  account_name                 = each.value.storage_account.name
  share_name                   = each.value.storage_account.file_share_name
  access_key                   = data.azurerm_storage_account.file_share[each.key].primary_access_key
  access_mode                  = each.value.access_mode
}
