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

variable "resources" {
  type = list(object({
    name                = string
    type                = string
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
    condition     = length([for resource in var.var.resources : resource.name]) == length(distinct([for resource in var.resources : trimspace(lower(resource.name))]))
    error_message = "At least one 'name' property from one of the 'resources' is duplicated. They must be unique."
  }

  validation {
    condition     = alltrue([for resource in var.resources : contains(["resource_group"], resource.type)])
    error_message = "At least one 'type' property from 'policies' is invalid. Valid options are 'resource_group'."
  }
}

