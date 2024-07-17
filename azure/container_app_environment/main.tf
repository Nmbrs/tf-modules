
# resource "azurerm_container_app_environment_certificate" "example" {
#   name                         = "myfriendlyname"
#   container_app_environment_id = azurerm_container_app_environment.example.id
#   certificate_blob_base64      = filebase64("path/to/certificate_file.pfx")
#   certificate_password         = ""
# }

resource "azurerm_container_app_environment" "container_app_environment" {
  name                           = local.container_app_environment_name
  location                       = var.location
  resource_group_name            = var.resource_group_name
  log_analytics_workspace_id     = data.azurerm_log_analytics_workspace.workspace.id
  infrastructure_subnet_id       = data.azurerm_subnet.container_app_environment.id
  internal_load_balancer_enabled = true

  lifecycle {
    ignore_changes = [tags]
  }
}

resource "azurerm_container_app_environment_storage" "file_share" {
  for_each = { for settings in file_share_settings : settings => settings.name }

  name                         = lower(mycontainerappstorage)
  container_app_environment_id = azurerm_container_app_environment.container_app_environment.id
  account_name                 = each.value.storage_account.name
  share_name                   = each.value.storage_account.share_name
  access_key                   = azurerm_storage_account.example.primary_access_key
  access_mode                  = "ReadOnly"
}
