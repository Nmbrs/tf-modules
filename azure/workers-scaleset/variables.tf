variable "vm_resourcegroup" {
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