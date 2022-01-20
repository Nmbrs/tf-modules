variable "tags" {
  description = "nmbrs environment resource tag."
  type = map(string)
}

variable "project" {
  description = "project name. It will be used by some resources."
  type        = string
}
variable "plan" {
  description = "azure app service plan name (PremiumV2, Standard, etc)"
  type = string
}

variable "size" {
  description = "azure app service machine type (P1V3, P2V1, etc)"
  type = string
}

variable "location" {
  description = "azure region."
  type = string
  default = "West Europe"
}