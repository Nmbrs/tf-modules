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

variable "sku_tier" {
  description = "app service plan tier [PremiumV2 or PremiumV3]"
  type        = string

  validation {
    condition = contains(["PremiumV2", "PremiumV3"], var.sku_tier)
    

    error_message = "sku tier must be either PremiumV2 or PremiumV3"
  }
}

variable "sku_size" {
  description = "app service plan instance sizetype [P1, P2 or P3]"
  type        = string

  validation {
    condition = contains(["P1", "P2", "P3"], var.sku_size)

    error_message = "sku size must be P1."
  }
}