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
    roles               = list(string)
  }))
  default     = []
  description = "A list of resources with their details, including name, type, ID, resource group name, and roles."

  # Validation for non-empty names
  validation {
    condition     = alltrue([for resource in var.resources : can(coalesce(resource.name))])
    error_message = "At least one 'name' property from 'resources' is invalid. They must be non-empty string values."
  }

  # Validation: for unique names
  validation {
    condition     = length([for resource in var.resources : resource.name]) == length(distinct([for resource in var.resources : trimspace(lower(resource.name))]))
    error_message = "At least one 'name' property from one of the 'resources' is duplicated. They must be unique."
  }

  # Validation for resource types
  validation {
    condition     = alltrue([for resource in var.resources : contains(["custom", "resource_group", "key_vault", "storage_account", "service_bus", "app_configuration", "cosmosdb_sql_account"], resource.type)])
    error_message = "At least one 'type' property from 'resources' is invalid. Valid options are 'custom' 'resource_group', 'key_vault', 'storage_account', 'service_bus', 'app_configuration', 'cosmosdb_sql_account'."
  }

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

  # Validation for custom resources
  validation {
    condition     = alltrue([for resource in var.resources : resource.type != "custom" || (resource.id != null && resource.resource_group_name == null)])
    error_message = "At least one 'custom' resource is missing a required 'id' or has an incorrectly set 'resource_group_name'. When 'type' is 'custom', 'id' is required and 'resource_group_name' must not be set."
  }

  # Validation for non-custom resources
  validation {
    condition     = alltrue([for resource in var.resources : resource.type == "custom" || (resource.resource_group_name != null && (resource.id == null || resource.id == ""))])
    error_message = "At least one non-'custom' resource is missing a required 'resource_group_name' or has an incorrectly set 'id'. When 'type' is not 'custom', 'resource_group_name' is required, and 'id' must be null or empty."
  }
}
