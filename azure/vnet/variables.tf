variable "resource_group_name" {
  type        = string
  description = "The name of the resource group in which to create the virtual network."
}

variable "name" {
  description = "The name of the virtual network."
  type        = string
}

variable "environment" {
  description = "(Optional) The environment in which the resource should be provisioned."
  type        = string
  default     = ""

  validation {
    condition     = contains(["dev", "prod", "stag", "test", "sand"], var.environment)
    error_message = "The 'environment' value is invalid. Valid options are 'dev', 'prod','stag', 'test', 'sand'."
  }
}

variable "extra_tags" {
  description = "(Optional) A extra mapping of tags which should be assigned to the desired resource."
  type        = map(string)
  default     = {}

  validation {
    condition     = alltrue([for tag in var.extra_tags : can(coalesce(tag))])
    error_message = "At least on tag value from 'extra_tags' is invalid. They must be non-empty string values."
  }
}

variable "address_spaces" {
  description = "The address space that is used the virtual network."
  type        = list(string)
  default     = []

  # validation {
  #   condition     = alltrue([for address_space in var.address_spaces : can(cidrhost(address_spaces, 0))])
  #   error_message = "At least one 'name' property from 'policies' is invalid. They must be non-empty string values."
  # }
}

# variable "subnets" {
#   type = list(object({
#     name      = string
#     object_id = string
#     type      = string
#   }))
#   default     = []
#   description = "List of objects that represent the configuration of each subnet."
# }

