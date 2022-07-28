variable "resource_group_name" {
  description = "The name of the resource group in which to create the virtual machine."
  type        = string
}

variable "name" {
  description = "The name of the virtual machine."
  type        = string
}

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

  variable "os_type" {
    description = "The environment in which the resource should be provisioned."
    type        = string

    validation {
      condition     = contains(["ubuntu 22.04 lts", "ubuntu 18.04 lts", "ubuntu 18.04 lts", "debian 10", "debian 11", "windows server 2016", "windows server 2019", "windows server 2022", "sql server 2017", "sql server 2019", "sql server 2022"], lower(var.os_type))
      error_message = "The 'os_type' value is invalid. Valid options are 'ubuntu 22.04 lts', 'ubuntu 18.04 lts', 'ubuntu 18.04 lts', 'debian 10', 'debian 11', 'windows server 2016', 'windows server 2019', 'windows server 2022', 'sql server 2017', 'sql server 2019', 'sql server 2022'."
    }
  }

}
