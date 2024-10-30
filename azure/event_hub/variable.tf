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

variable "event_hub" {
  description = "The names of the event hubs"
  type        = list(string)
  default     = []
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
