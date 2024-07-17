variable "workload" {
  description = "The name of the workload associated with the resource."
  type        = string
}

variable "resource_group_name" {
  type        = string
  description = "The name of an existing Resource Group."
}

# variable "naming_count" {
#   description = "A numeric sequence number used for naming the resource. It ensures a unique identifier for each resource instance within the naming convention."
#   type        = number

#   validation {
#     condition     = var.naming_count >= 1 && var.naming_count <= 999
#     error_message = format("Invalid value '%s' for variable 'naming_count'. It must be between 1 and 999.", var.naming_count)
#   }
# }

variable "environment" {
  description = "The environment in which the resource should be provisioned."
  type        = string
}

variable "location" {
  description = "The location where the resources will be deployed in Azure. For an exaustive list of locations, please use the command 'az account list-locations -o table'."
  type        = string
}

variable "network_settings" {
  description = "Settings related to the network connectivity of the application gateway."
  type = object({
    vnet_name                = string
    vnet_resource_group_name = string
    subnet_name              = string
  })
}

variable "log_analytics_worspace_settings" {
  description = "A list of settings related to the log analytics workspace."
  type = object({
    name                = string
    resource_group_name = string
  })
}

# variable "file_share_settings" {
#   type = list(object({
#     name        = string
#     access_mode = string //"ReadOnly" "ReadWrite"
#     storage_account = object({
#       name       = string
#       share_name = string
#       access_key = object({
#         key_vault_name                = string
#         key_vault_resource_group_name = string
#         key_vault_secret_name    = string
#       })
#     })
#   }))
# }

# variable "managed_identity_settings" {
#   description = "A list of settings related to the app gateway managed identity used to retrieve SSL certificates."
#   type = object({
#     name                = string
#     resource_group_name = string
#   })
# }

# variable "ssl_certificates" {
#   description = "Settings related to SSL certificates that will be installed in the application gateway."
#   type = list(object({
#     name                          = string
#     key_vault_name                = string
#     key_vault_resource_group_name = string
#     key_vault_certificate_name    = string
#   }))
#   default = []
# }
