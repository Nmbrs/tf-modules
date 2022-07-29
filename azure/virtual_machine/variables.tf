variable "resource_group_name" {
  description = "The name of the resource group in which to create the virtual machine."
  type        = string
}

variable "name" {
  description = "The name of the virtual machine."
  type        = string
}

# variable "product" {
#   description = "Name of the product to which the resources belongs."
#   type        = string

#   validation {
#     condition     = can(coalesce(var.product))
#     error_message = "The 'product' value is invalid. It must be a non-empty string."
#   }
# }

# variable "squad" {
#   description = "Name of the squad to which the resources belongs."
#   type        = string

#   validation {
#     condition     = can(coalesce(var.squad))
#     error_message = "The 'squad' value is invalid. It must be a non-empty string."
#   }
# }

# variable "country" {
#   description = "Name of the country to which the resources belongs."
#   type        = string

#   validation {
#     condition     = can(coalesce(var.country))
#     error_message = "The 'country' value is invalid. It must be a non-empty string."
#   }
# }

variable "environment" {
  description = "The environment in which the resource should be provisioned."
  type        = string

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
    error_message = "At least one tag value from 'extra_tags' is invalid. They must be non-empty string values."
  }
}

variable "os_type" {
  description = "The environment in which the resource should be provisioned."
  type        = string

  validation {
    condition     = contains(["ubuntu 22.04 lts", "ubuntu 18.04 lts", "ubuntu 18.04 lts", "debian 10", "debian 11", "windows server 2016", "windows server 2019", "windows server 2022", "sql server 2017", "sql server 2019", "sql server 2022"], lower(var.os_type))
    error_message = "The 'os_type' value is invalid. Valid options are 'ubuntu 22.04 lts', 'ubuntu 18.04 lts', 'ubuntu 18.04 lts', 'debian 10', 'debian 11', 'windows server 2016', 'windows server 2019', 'windows server 2022', 'sql server 2017', 'sql server 2019', 'sql server 2022'."
  }
}

variable "ssh_public_key" {
  description = "Specifies the SSH public key used to access the virtual_machine."
  type        = string
}

variable "admin_username" {
  description = "Specifies The administrator username for which the SSH Key should be configured."
  type        = string
  default     = "automation"
}


variable "vnet_subnet_id" {
  description = "The ID of a Subnet where the Kubernetes Node Pool should exist. Changing this forces a new resource to be created."
  type        = string
}
