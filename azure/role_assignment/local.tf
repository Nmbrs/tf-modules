locals {
  resource_data_blocks = {
    resource_group = data.azurerm_resource_group.resource_group
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
          role_name                    = role
        }
      ]
    ]
  )
}

