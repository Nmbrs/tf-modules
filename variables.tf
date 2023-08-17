variable "project_name" {
  default = "tf-pr-filipe"
}

variable "environment" {
  default = "dev"
}

variable "location" {
  default = "westeurope"
}


variable "product" {
  description = "Name of the product to which the resources belongs."
  type        = string
  default     = "not_applicable"
}

variable "category" {
  description = "High-level identification name that supports product components."
  type        = string
  default     = "not_applicable"
}

variable "owner" {
  description = "Name of the squad to which the resources belongs."
  type        = string
  default     = "infra"
}

variable "country" {
  description = "Name of the country to which the resources belongs."
  type        = string
  default     = "global"
}

variable "status" {
  description = "Indicates the resource state that can lead to post actions (either manually or automatically)."
  type        = string
  default     = "temporary"
}














## Virtual Machine
variable "vm_linux_name" {
  type    = string
  default = "vmlinuxdev"
}

variable "vm_windows_name" {
  type    = string
  default = "vmwindev"
}
