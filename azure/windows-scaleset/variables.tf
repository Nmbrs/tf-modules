variable "project" {
  type        = string
  description = "This variable defines the project name to be interpolated in multiple resources."
}

variable "vm_resource_group" {
  type = string
  description = "Resource group name"
}

variable "vm_size" {
  type        = string
  description = "Azure virtual machine machine size. [Standard_F2s_v2, Standard_F4s_v2,Standard_F8s_v2, Standard_F16s_v2, Standard_F32s_v2, Standard_F48s_v2, Standard_F64s_v2, Standard_F72s_v2]"
}

variable "vm_count" {
  type        = number
  description = "Number of virtual machines to be created on the scale set."
}

variable "vm_extension_custom_script" {
  type = string
  description = "defines the script to be executed as an extension."
}

variable "vnet_resource_group_name" {
  type        = string
  description = "defines the vnet resource group."

}

variable "vnet_virtual_network_name" {
  type        = string
  description = "defines the azure vnet virtual network."

}

variable "vnet_name" {
  type        = string
  description = "defines azure vnet name."
}