resource "azurerm_container_app" "example" {
  name                         = local.container_app_name
  container_app_environment_id = data.azurerm_container_app_environment.container_environment.id
  workload_profile_name        = "Consumption"
  resource_group_name          = var.resource_group_name
  revision_mode                = "Single"

  # registry {
  #   password_secret_name = "container_registry_password"
  #   server               = data.azurerm_container_registry.container_registry.login_server
  #   username             = data.azurerm_container_registry.container_registry.admin_username
  # }

  # secret {
  #   name  = "container_registry_password"
  #   value = data.azurerm_container_registry.container_registry.admin_password
  # }

  template {
    container {
      name   = local.container_app_name
      image  = "${data.azurerm_container_registry.container_registry.login_server}/third-parties/hello-world:latest"
      cpu    = 0.25
      memory = "0.5Gi"
    }
  }

  identity {
    type         = "UserAssigned"
    identity_ids = [data.azurerm_user_assigned_identity.identity.id]
  }

  lifecycle {
    ignore_changes = [tags, template, dapr, ingress, registry, secret]
  }
}
