variable "project" {
  type        = string
  description = "This variable defines the project name to be interpolated in multiple resources."
}

variable "vm_resource_group" {
  type        = string
  description = "Resource group name"
}
variable "location" {
  description = "The location where the resources will be deployed in Azure. For an exaustive list of locations, please use the command 'az account list-locations -o table'."
  type        = string
}

variable "environment" {
  type        = string
  description = "defines the environment to provision the resources."
}

variable "vm_size" {
  type        = string
  description = "Azure virtual machine machine size. [Standard_F2s_v2, Standard_F4s_v2,Standard_F8s_v2, Standard_F16s_v2, Standard_F32s_v2, Standard_F48s_v2, Standard_F64s_v2, Standard_F72s_v2]"
}

variable "vm_count" {
  type        = number
  description = "Number of virtual machines to be created on the scale set."
}

variable "vnet_resource_group_name" {
  type        = string
  description = "defines the vnet resource group."

}

variable "vnet_virtual_network_name" {
  type        = string
  description = "defines the azure vnet virtual network."

}

variable "subnet_name" {
  type        = string
  description = "defines azure subnet name."
}

variable "max_number_threads" {
  type        = number
  description = "defines the max number of threads that the worker can fire up."
}

variable "queue_name" {
  type        = string
  description = "defines the queue that the worker will be listening for events."
}