locals {
  resource_data_blocks = {
    resource_group    = data.azurerm_resource_group.resource_group
    key_vault         = data.azurerm_key_vault.key_vault
    storage_account   = data.azurerm_storage_account.storage_account
    service_bus       = data.azurerm_servicebus_namespace.service_bus
    app_configuration = data.azurerm_app_configuration.app_configuration
    # Add more resource types and corresponding data blocks as needed
  }

  principal_data_blocks = {
    security_group    = data.azuread_group.security_group,
    service_principal = data.azuread_service_principal.service_principal,
    managed_identity  = data.azuread_service_principal.managed_identity,
    user              = data.azuread_user.user

    # Add more resource types and corresponding data blocks as needed
  }

  principal_type = {
    security_group    = "Group"
    user              = "User"
    managed_identity  = "ServicePrincipal"
    service_principal = "ServicePrincipal"
  }

  assignments = flatten(
    [
      for resource in var.resources : [
        for role in resource.roles : {
          resource_name                = resource.name
          resource_type                = resource.type
          resource_resource_group_name = resource.resource_group_name
          resource_subscription_name   = resource.subscription_name
          resource_id                  = resource.id
          role_name                    = role
        }
      ]
    ]
  )
}

