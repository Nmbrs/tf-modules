variable "workload" {
  type        = string
  description = "Short, descriptive name for the application, service, or workload."
}

variable "override_name" {
  type        = string
  description = "Optional override for naming logic."
  default     = null

  validation {
    condition     = var.override_name == null || try(length(trim(var.override_name, "")) > 0, false)
    error_message = "override_name must be a non-empty string."
  }
}

variable "company_prefix" {
  type        = string
  description = "Short, unique prefix for the company/organization."
  default     = "nmbrs"

  validation {
    condition     = length(trimspace(var.company_prefix)) > 0 && length(var.company_prefix) <= 5
    error_message = "company_prefix must be a non-empty string with a maximum of 5 characters."
  }
}

variable "resource_group_name" {
  type        = string
  description = "Name of the Azure Resource Group."
}

variable "location" {
  type        = string
  description = "Azure region for resource deployment."
  default     = "westeurope"
}

variable "environment" {
  type        = string
  description = "The environment for the resource (e.g., dev, test, prod, stag, sand)."

  validation {
    condition     = contains(["dev", "test", "prod", "stag", "sand"], var.environment)
    error_message = "Environment must be one of: dev, test, prod, stag, sand."
  }
}

variable "sequence_number" {
  type        = number
  description = "A numeric value used to ensure uniqueness for resource names."

  validation {
    condition     = var.sequence_number >= 1 && var.sequence_number <= 999
    error_message = "sequence_number must be between 1 and 999."
  }
}

variable "application_backend_settings" {
  description = "A list of settings for the application backends that the app gateway will serve."
  type = list(object({
    routing_rule = object({
      priority = number
    })
    listener = object({
      fqdn             = string
      protocol         = string
      certificate_name = optional(string, null)
    })
    backend = object({
      fqdns                         = list(string)
      port                          = number
      protocol                      = string
      cookie_based_affinity_enabled = optional(bool, false)
      request_timeout_in_seconds    = optional(number, 30)
      health_probe = object({
        timeout_in_seconds             = number
        evaluation_interval_in_seconds = number
        unhealthy_treshold_count       = number
        fqdn                           = string
        path                           = string
        status_codes                   = list(string)
      })
    })
  }))

  default = []
}

variable "redirect_url_settings" {
  description = "A list of settings for the URL redirection that the app gateway will serve."
  type = list(object({
    routing_rule = object({
      priority = number
    })
    listener = object({
      fqdn             = string
      protocol         = string
      certificate_name = optional(string, null)
    })
    target = object({
      url                  = string
      include_path         = optional(bool, false)
      include_query_string = optional(bool, false)
    })
  }))

  default = []
}

variable "redirect_listener_settings" {
  description = "A list of settings for the listeners redirection that the app gateway will serve."
  type = list(object({
    routing_rule = object({
      priority = number
    })
    listener = object({
      fqdn             = string
      protocol         = string
      certificate_name = optional(string, null)
    })
    target = object({
      listener_name        = string
      include_path         = bool
      include_query_string = bool
    })
  }))
  default = []
}

variable "network_settings" {
  description = "Settings related to the network connectivity of the application gateway."
  type = object({
    vnet_name                = string
    vnet_resource_group_name = string
    subnet_name              = string
  })
}

variable "managed_identity_settings" {
  description = "A list of settings related to the app gateway managed identity used to retrieve SSL certificates."
  type = object({
    name                = string
    resource_group_name = string
  })
}

variable "ssl_certificates" {
  description = "Settings related to SSL certificates that will be installed in the application gateway."
  type = list(object({
    name                          = string
    key_vault_name                = string
    key_vault_resource_group_name = string
    key_vault_certificate_name    = string
  }))
  default = []
}

variable "min_instance_count" {
  description = "The minimum number of instances the application gateway will have."
  type        = number
  default     = 2
}

variable "max_instance_count" {
  description = "The maximum number of instances the application gateway will have."
  type        = number
  default     = 10
}

variable "waf_policy_settings" {
  description = "Name of the WAF policy to be associated with the application gateway."
  type = object({
    name                = string
    resource_group_name = string
  })
}


