variable "principal_type" {
  type        = string
  description = "The type of pricipal to which roles will be assigned."

  validation {
    condition     = contains(["user", "service_principal", "managed_identity", "security_group"], var.principal_type)
    error_message = format("Invalid value '%s' for variable 'var.principal_type'. Valid options are 'user', 'service_principal', 'managed_identity', 'security_group'.", var.principal_type)
  }
}

variable "principal_name" {
  type        = string
  description = "The name of the principal to assign roles to."
}

variable "resources" {
  type = list(object({
    name                = string
    type                = string
    id                  = optional(string, null)
    resource_group_name = optional(string, null)
    subscription_name   = optional(string, null)
    roles               = list(string)
  }))
  default = []

  validation {
    condition     = alltrue([for resource in var.resources : can(coalesce(resource.name))])
    error_message = "At least one 'name' property from 'resources' is invalid. They must be non-empty string values."
  }

  validation {
    condition     = length([for resource in var.resources : resource.name]) == length(distinct([for resource in var.resources : trimspace(lower(resource.name))]))
    error_message = "At least one 'name' property from one of the 'resources' is duplicated. They must be unique."
  }

  validation {
    condition     = alltrue([for resource in var.resources : contains(["custom", "resource_group", "key_vault", "storage_account", "service_bus", "app_configuration"], resource.type)])
    error_message = "At least one 'type' property from 'resources' is invalid. Valid options are 'custom' 'resource_group', 'key_vault', 'storage_account', 'service_bus', 'app_configuration'."
  }

  validation {
    condition     = alltrue([for resource in var.resources : length(resource.roles) == length(distinct(resource.roles))])
    error_message = "At least one 'role' property from one of the 'resources' is duplicated. They must be unique."
  }

  validation {
    condition     = alltrue([for resource in var.resources : resource.type == "custom" ? resource.id != "" && resource.id != null : true])
    error_message = "At least one 'id' property from one of the 'resources' is invalid. They must be non-empty string values when the property 'type' is set to 'custom'"
  }
}

