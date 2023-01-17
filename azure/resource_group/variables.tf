variable "name" {
  description = "Name of the resource group. It must follow the CAF naming convention."
  type        = string

  validation {
    condition     = can(coalesce(var.name))
    error_message = "The 'name' value is invalid. It must be a non-empty string."
  }
}

variable "location" {
  description = "The location where the resources will be deployed in Azure. For an exaustive list of locations, please use the command 'az account list-locations -o table'."
  type        = string
}

variable "environment" {
  description = "The environment in which the resource should be provisioned."
  type        = string
}

variable "product" {
  description = "(Optional) Name of the product to which the resource belongs."
  type        = string
  default     = "not_applicable"

  validation {
    condition     = can(coalesce(var.product))
    error_message = "The 'product' value is invalid. It must be a non-empty string."
  }
}

variable "category" {
  description = "(Optional) High-level identification name that supports product components."
  type        = string
  default     = "not_applicable"

  validation {
    condition     = can(coalesce(var.category))
    error_message = "The 'categoy' value is invalid. It must be a non-empty string."
  }
}

variable "owner" {
  description = "(Optional) Name of the owner to which the resource belongs."
  type        = string
  default     = "not_applicable"

  validation {
    condition     = can(coalesce(var.owner))
    error_message = "The 'owner' value is invalid. It must be a non-empty string."
  }
}

variable "country" {
  description = "(Optional) Name of the country to which the resources belongs."
  type        = string
  default     = "global"

  validation {
    condition     = contains(["global", "nl", "se"], var.country)
    error_message = "The 'country' value is invalid. Valid options are 'global', 'nl','se'."
  }
}

variable "status" {
  description = "(Optional) Indicates the resource state that can lead to post actions (either manually or automatically)."
  type        = string
  default     = "life_cycle"

  validation {
    condition     = contains(["life_cycle", "not_compliant", "suspicious", "temporary", "to_delete", "to _review"], var.status)
    error_message = "The 'status' value is invalid. Valid options are 'life_cycle', 'not_compliant', 'suspicious', 'temporary', 'to_delete', 'to _review'."
  }
}

variable "extra_tags" {
  description = "(Optional) A extra mapping of tags which should be assigned to the desired resource."
  type        = map(string)
  default     = {}

  validation {
    condition     = alltrue([for tag in var.extra_tags : can(coalesce(var.extra_tags))])
    error_message = "At least on tag value from 'extra_tags' is invalid. They must be non-empty string values."
  }
}
