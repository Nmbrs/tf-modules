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
    id    = optional(string, null)
    roles = list(string)
  }))
  default     = []
  description = "A list of resources with their details, including name, type, ID, resource group name, and roles."

  # Validation for non-empty roles
  validation {
    condition     = alltrue([for resource in var.resources : length(resource.roles) > 0])
    error_message = "At least one 'role' list is invalid. They must be non-empty."
  }

  # Validation for unique roles
  validation {
    condition     = alltrue([for resource in var.resources : length(resource.roles) == length(distinct(resource.roles))])
    error_message = "At least one 'role' property from one of the 'resources' is duplicated. They must be unique."
  }
}
