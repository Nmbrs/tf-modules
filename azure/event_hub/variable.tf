variable "workload" {
  description = "The workload name of the event grid domain."
  type        = string
}

variable "resource_group_name" {
  description = "Specifies the name of the Resource Group where the resource should exist."
  type        = string
}

variable "environment" {
  description = "The environment in which the resource should be provisioned."
  type        = string
}

variable "location" {
  description = "The location where the resources will be deployed in Azure. For an exaustive list of locations, please use the command 'az account list-locations -o table'."
  type        = string
}

variable "event_hubs_settings" {
  description = "Configuration settings for the Event Hubs, including names, consumer groups, and authorization rules."
  type = list(object({
    name = string
    consumer_groups = list(object({
      name              = string
      partition_count   = number
      message_retention = number
    }))
    authorization_rules = list(object({
      name   = string
      listen = bool
      send   = bool
      manage = bool
    }))
  }))
}

variable "capacity" {
  description = "The capacity of the event hub namespace."
  type        = number
}

variable "auto_inflate_enabled" {
  description = "The auto inflate enabled of the event hub namespace."
  type        = bool
}

variable "maximum_throughput_units" {
  description = "The maximum throughput units of the event hub namespace."
  type        = number

}

variable "sku" {
  description = "The sku of the event hub namespace."
  type        = string

  validation {
    condition     = contains(["Basic", "Standard", "Premium"], var.sku)
    error_message = "The sku must be either Basic, Standard or Premium."
  }
}
