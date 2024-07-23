
# resource "azurerm_container_app_environment_certificate" "example" {
#   name                         = "myfriendlyname"
#   container_app_environment_id = azurerm_container_app_environment.example.id
#   certificate_blob_base64      = filebase64("path/to/certificate_file.pfx")
#   certificate_password         = ""
# }

resource "azurerm_container_app_environment" "container_app_environment" {
  name                       = local.container_app_environment_name
  location                   = var.location
  resource_group_name        = var.resource_group_name
  log_analytics_workspace_id = data.azurerm_log_analytics_workspace.workspace.id
  infrastructure_subnet_id   = data.azurerm_subnet.container_app_environment.id

  workload_profile {
    name                  = "Consumption"
    workload_profile_type = "Consumption"
    maximum_count         = 10
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
  type        = "Microsoft.App/managedEnvironments@2024-03-01"
  resource_id = azurerm_container_app_environment.container_app_environment.id

  body = jsonencode({
    identity = {
      type = "UserAssigned"
      userAssignedIdentities = {
        "${data.azurerm_user_assigned_identity.identity.id}" = {}
      }
    }
    # properties = {
    #   privacy       = true
    #   autoRenew     = true
    #   targetDnsType = "AzureDns"
    # }
  })

    #   properties = {
    #   identity = {
    #     type = "UserAssigned",
    #     userAssignedIdentities = {
    #       a = {}
    #     }
    #   }
    # }

  depends_on = [azurerm_container_app_environment.container_app_environment]
}

# resource "azurerm_container_app_environment_storage" "file_share" {
#   for_each = { for settings in file_share_settings : settings => settings.name }

#   name                         = lower(mycontainerappstorage)
#   container_app_environment_id = azurerm_container_app_environment.container_app_environment.id
#   account_name                 = each.value.storage_account.name
#   share_name                   = each.value.storage_account.share_name
#   access_key                   = azurerm_storage_account.example.primary_access_key
#   access_mode                  = "ReadOnly"
# }
