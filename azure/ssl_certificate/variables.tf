variable "domain_name" {
  description = "The name of the domain."
  type        = string

  # Notes: Validations imposed by Microsoft in Azure Portal
  validation {
    # Length validation between 4 and 64 characters.
    condition     = length(var.domain_name) >= 4 && length(var.domain_name) <= 64
    error_message = "The domain name must be between 4 and 64 characters long."
  }

  validation {
    # Ensure the domain contains a TLD (at least one dot and characters after it).
    condition     = length(split(".", var.domain_name)) >= 2
    error_message = "The domain name must contain at least one top-level domain (TLD)."
  }

  validation {
    # Ensures that the domain contains only alphanumeric characters and hyphens in each label.
    condition     = alltrue([for label in split(".", var.domain_name) : can(regex("^[a-zA-Z0-9-]+$", label))])
    error_message = "The domain name can only contain alphanumeric characters and hyphens."
  }

  validation {
    # Ensures that none of the labels begin or end with a hyphen.
    condition     = alltrue([for label in split(".", var.domain_name) : !can(regex("(^-|-$)", label))])
    error_message = "The domain name labels cannot begin or end with a hyphen."
  }
}

variable "resource_group_name" {
  type        = string
  description = "The name of an existing Resource Group."
}

variable "override_name" {
  description = "Override the name of the certificate, to bypass naming convention"
  type        = string
  nullable    = true
  default     = null
}
