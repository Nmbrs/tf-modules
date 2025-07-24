variable "workload" {
  type        = string
  description = "Short, descriptive name for the application, service, or workload."

  validation {
    condition     = var.workload == null || try(length(trim(var.workload, "")) > 0, false)
    error_message = format("Invalid value '%s' for variable 'workload', it must be null or a non-empty string.", coalesce(var.workload, "null"))
  }
}

variable "company_prefix" {
  type        = string
  description = "Short, unique prefix for the company/organization."
  default     = "nmbrs"
  nullable    = false

  validation {
    condition     = length(trimspace(var.company_prefix)) > 0 && length(var.company_prefix) <= 5
    error_message = format("Invalid value '%s' for variable 'company_prefix', it must be a non-empty string with a maximum of 5 characters.", var.company_prefix)
  }
}

variable "override_name" {
  type        = string
  description = "Optional override for naming logic."
  default     = null

  validation {
    condition     = var.override_name == null || try(length(trim(var.override_name, "")) > 0, false)
    error_message = format("Invalid value '%s' for variable 'override_name', it must be null or a non-empty string.", coalesce(var.override_name, "null"))
  }
}

variable "resource_group_name" {
  type        = string
  description = "Specifies the name of the resource group where the resource should exist."
  nullable    = false

  validation {
    condition     = try(length(trim(var.resource_group_name, "")) > 0, false)
    error_message = format("Invalid value '%s' for variable 'resource_group_name', it must be a non-empty string.", var.resource_group_name)
  }
}


variable "location" {
  type        = string
  description = "The location where the resources will be deployed in Azure. For an exaustive list of locations, please use the command 'az account list-locations -o table'."
  nullable    = false

  validation {
    condition     = try(length(trim(var.location, "")) > 0, false)
    error_message = format("Invalid value '%s' for variable 'location', it must be a non-empty string.", var.location)
  }
}


variable "environment" {
  type        = string
  description = "The environment in which the resource should be provisioned."

  validation {
    condition     = contains(["dev", "test", "prod", "sand", "stag"], var.environment)
    error_message = format("Invalid value '%s' for variable 'environment', valid options are 'dev', 'test', 'prod', 'sand', 'stag'.", var.environment)
  }
}

variable "sequence_number" {
  type        = number
  description = "A numeric value used to ensure uniqueness for resource names."

  validation {
    condition     = var.sequence_number >= 1 && var.sequence_number <= 999
    error_message = format("Invalid value '%s' for variable 'sequence_number', it must be between a number between 1 and 999.", var.sequence_number)
  }
}

variable "application_backend_settings" {
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
  description = "A list of settings for the application backends that the app gateway will serve."
  default     = []
}

variable "redirect_url_settings" {
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
  description = "A list of settings for the URL redirection that the app gateway will serve."
  default     = []
}

variable "redirect_listener_settings" {
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
  description = "A list of settings for the listeners redirection that the app gateway will serve."
  default     = []
}

variable "network_settings" {
  type = object({
    vnet_name                = string
    vnet_resource_group_name = string
    subnet_name              = string
  })
  description = "Settings related to the network connectivity of the application gateway."
}

variable "managed_identity_settings" {
  type = object({
    name                = string
    resource_group_name = string
  })
  description = "A list of settings related to the app gateway managed identity used to retrieve SSL certificates."
}

variable "ssl_certificates" {
  type = list(object({
    name                          = string
    key_vault_name                = string
    key_vault_resource_group_name = string
    key_vault_certificate_name    = string
  }))
  description = "Settings related to SSL certificates that will be installed in the application gateway."
  default     = []
}

variable "min_instance_count" {
  type        = number
  description = "The minimum number of instances the application gateway will have."
  default     = 2
}

variable "max_instance_count" {
  type        = number
  description = "The maximum number of instances the application gateway will have."
  default     = 10
}

variable "waf_policy_settings" {
  type = object({
    name                = string
    resource_group_name = string
  })
  description = "Name of the WAF policy to be associated with the application gateway."
}


