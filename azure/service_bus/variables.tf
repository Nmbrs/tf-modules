variable "name" {
  description = "The name of the namespace."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the rg."
  type        = string
}

variable "location" {
  description = "The name of the location."
  type        = string
}

variable "sku" {
  description = "The SKU of the namespace. The options are: `Basic`, `Standard`, `Premium`."
  type        = string
  default     = "Standard"
}

variable "capacity" {
  description = "The number of message units."
  type        = number
  default     = 0
}
