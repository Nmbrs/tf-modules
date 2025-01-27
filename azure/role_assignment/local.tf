locals {
  principal_data_blocks = {
    security_group    = data.azuread_group.security_group,
    service_principal = data.azuread_service_principal.service_principal,
    managed_identity  = data.azuread_service_principal.managed_identity,
    user              = data.azuread_user.user

    # Add more principal types and corresponding data blocks as needed
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
          resource_name = lower(element(split("/", resource.id), length(split("/", resource.id)) - 1))
          resource_id   = resource.id
          role_name     = role
        }
      ]
    ]
  )
}
