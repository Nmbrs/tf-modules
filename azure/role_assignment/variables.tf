variable "principal_type" {
  type    = string
  default = "value"

  validation {
    condition     = contains(["user", "service_principal", "managed_identity", "security_group"], var.principal_type)
    error_message = format("Invalid value '%s' for variable 'var.principal_type'. Valid options are 'user', 'service_principal', 'managed_identity', 'security_group'.", var.principal_type)
  }
}

variable "principal_name" {
  type     = string
  nullable = true
  default  = null
}

# variable "principal_resource_group" {
#   type = string
# }

variable "resource_name" {
  type     = string
  nullable = true
  default  = null
}

variable "resource_type" {
  type = string

  #   validation {
  #   condition     = contains(["service_bus", "service_bus_queue", "storage_account", "key_vault", "app_configuration", "resource_group", "container_registry", "cosmos_db_nosql"], var.resource_settings.type)
  #   error_message = format("Invalid value '%s' for variable 'resource_settings.type'. Valid options are 'service_bus', 'service_bus_queue', 'storage_account', 'key_vault', 'app_configuration', 'key_vault', 'resource_group', 'container_registry', 'cosmos_db_nosql'.", var.resource_settings.type)
  # }
  validation {
    condition     = contains(["resource_group", "subscription"], var.resource_type)
    error_message = format("Invalid value '%s' for variable 'var.resource_type'. Valid options are 'resource_group'.", var.resource_type)
  }
}

variable "resource_group_name" {
  type     = string
  nullable = true
  default  = null
}

variable "subscription_name" {
  type     = string
  nullable = true
  default  = null
}

variable "roles" {
  type = list(string)

}

# variable "resource_settings" {
#   description = "Defines the settings for the associated resources, specifying the name, and the resource group for it."
#   type = object(
#     {
#       name                = optional(string, null)
#       type                = optional(string, null)
#       resource_group_name = optional(string, null)
#       subscription_name   = optional(string, null)
#       roles               = list(string)
#     }
#   )
#   validation {
#     condition     = contains(["service_bus", "service_bus_queue", "storage_account", "key_vault", "app_configuration", "resource_group", "container_registry", "cosmos_db_nosql"], var.resource_settings.type)
#     error_message = format("Invalid value '%s' for variable 'resource_settings.type'. Valid options are 'service_bus', 'service_bus_queue', 'storage_account', 'key_vault', 'app_configuration', 'key_vault', 'resource_group', 'container_registry', 'cosmos_db_nosql'.", var.resource_settings.type)
#   }
# }

# variable "environment" {
#   description = "The environment in which the resource should be provisioned."
#   type        = string
# }

