variable "organization" {
  description = "Organization name. It will be used by some resources."
  type        = string
}

variable "country" {
  description = "country"
  type        = string
}

variable "squad" {
  description = "squad"
  type        = string
}

variable "environment" {
  description = "environment"
  type        = string
}

variable "project" {
  description = "project name. It will be used by some resources."
  type        = string
}

variable "service" {
  description = "microservice or application string to be reused on resource naming"
  type        = string
}

variable "tags" {
  description = "Resource tags."
  type        = map(any)
}

variable "plan" {
  type = string
}

variable "size" {
  type = string
}