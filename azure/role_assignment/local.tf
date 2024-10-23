locals {
  resource_data_blocks = {
    resource_group = data.azurerm_resource_group.resourc,
    # Add more resource types and corresponding data blocks as needed
  }

  principal_data_blocks = {
    security_group    = data.azuread_group.security_group,
    service_principal = data.azuread_service_principal.service_principal
    managed_identity  = data.azuread_service_principal.managed_identity
    user              = data.azuread_user.user

    # Add more resource types and corresponding data blocks as needed
  }

  principal_type = {
    security_group    = "Group"
    user              = "User"
    managed_identity  = "ServicePrincipal"
    service_principal = "ServicePrincipal"


  }
}
