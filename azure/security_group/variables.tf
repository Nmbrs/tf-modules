variable "name" {
  description = "The name of the security group."
  type        = string
}

variable "dynamic_membership_enabled" {
  description = "The name of the security group."
  type        = bool
  default     = false
}

variable "dynamic_membership_rule" {
  description = "The name of the security group."
  type        = string
  default     = null
}
