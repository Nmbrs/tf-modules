variable "resource_group_name" {
  description = "Resource group name for where the resource will be created"
  type        = string
}

variable "workload" {
  description = "This variable defines the name of the resource."
  type        = string
}

variable "environment" {
  description = "Defines the environment to provision the resources."
  type        = string

}

variable "location" {
  description = "The location where the resources will be deployed in Azure. For an exaustive list of locations, please use the command 'az account list-locations -o table'."
  type        = string
}
