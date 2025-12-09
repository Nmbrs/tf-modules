variable "workload" {
  description = "The workload name of the event grid domain."
  type        = string

  validation {
    condition     = can(coalesce(var.workload))
    error_message = "The 'workload' value is invalid. It must be a non-empty string."
  }
}

variable "resource_group_name" {
  description = "Specifies the name of the Resource Group where the resource should exist."
  type        = string
}

variable "environment" {
  description = "The environment in which the resource should be provisioned."
  type        = string
  nullable    = false
}

variable "location" {
  description = "The location where the resources will be deployed in Azure. For an exaustive list of locations, please use the command 'az account list-locations -o table'."
  type        = string
}

variable "instance_count" {
  description = "The instance count of the document intelligence."
  type        = number

  validation {
    condition     = var.instance_count >= 1 && var.instance_count <= 999
    error_message = format("Invalid value '%s' for variable 'instance_count'. It must be between 1 and 999.", var.instance_count)
  }
}

variable "network_acls" {
  description = "The network ACLs for the document intelligence."
  type = object({
    default_action = string
    ip_rules       = list(string)
  })
  default = {
    default_action = "Allow"
    ip_rules       = []
  }
}

variable "autoscale_enabled" {
  description = "Enable dynamic throttling for the document intelligence."
  type        = bool
  default     = false
}
