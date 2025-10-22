variable "override_name" {
  description = "Optional override for naming logic."
  type        = string
  default     = null
  nullable    = true

  validation {
    condition     = var.override_name == null || try(length(trimspace(var.override_name)) > 0, false)
    error_message = format("Invalid value '%s' for variable 'override_name', it must be null or a non-empty string.", coalesce(var.override_name, "null"))
  }
}

variable "workload" {
  description = "Short, descriptive name for the application, service, or workload. Used in resource naming conventions."
  type        = string
  nullable    = true

  validation {
    condition     = var.workload == null || try(length(trimspace(var.workload)) > 0, false)
    error_message = format("Invalid value '%s' for variable 'workload', it must be null or a non-empty string.", coalesce(var.workload, "null"))
  }
}

variable "company_prefix" {
  description = "Short, unique prefix for the company / organization."
  type        = string
  nullable    = true

  validation {
    condition     = var.company_prefix == null || try(length(trimspace(var.company_prefix)) > 0 && length(var.company_prefix) <= 5, false)
    error_message = format("Invalid value '%s' for variable 'company_prefix', it must be a non-empty string with a maximum of 5 characters.", coalesce(var.company_prefix, "null"))
  }
}

variable "sequence_number" {
  description = "A numeric value used to ensure uniqueness for resource names."
  type        = number
  nullable    = true

  validation {
    condition     = var.sequence_number == null || try(var.sequence_number >= 1 && var.sequence_number <= 999, false)
    error_message = format("Invalid value '%s' for variable 'sequence_number', it must be null or a number between 1 and 999.", coalesce(var.sequence_number, "null"))
  }
}

variable "location" {
  description = "Specifies Azure location where the resources should be provisioned. For an exhaustive list of locations, please use the command 'az account list-locations -o table'."
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.location)) > 0
    error_message = format("Invalid value '%s' for variable 'location', it must be a non-empty string.", var.location)
  }
}

variable "environment" {
  description = "The environment in which the resource should be provisioned."
  type        = string
  nullable    = false

  validation {
    condition     = contains(["dev", "test", "prod", "sand", "stag"], var.environment)
    error_message = format("Invalid value '%s' for variable 'environment', valid options are 'dev', 'test', 'prod', 'sand', 'stag'.", var.environment)
  }
}

variable "resource_group_name" {
  description = "Specifies the name of the resource group where the resource should be provisioned."
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.resource_group_name)) > 0
    error_message = format("Invalid value '%s' for variable 'resource_group_name', it must be a non-empty string.", var.resource_group_name)
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
      rewrite_rules = object({
        headers = object({
          csp_enabled                         = bool
          hsts_enabled                        = bool
          additional_security_headers_enabled = bool
        })
      })
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
  default  = []
  nullable = false
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
  default  = []
  nullable = false
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
  default  = []
  nullable = false
}

variable "network_settings" {
  description = "Settings related to the network connectivity of the application gateway."
  type = object({
    vnet_name                = string
    vnet_resource_group_name = string
    subnet_name              = string
  })

  nullable = false

  validation {
    condition     = try(length(trimspace(var.network_settings.vnet_name)) > 0, false)
    error_message = format("Invalid value '%s' for variable 'network_settings.vnet_name', it must be a non-empty string.", coalesce(var.network_settings.vnet_name, "null"))
  }

  validation {
    condition     = try(length(trimspace(var.network_settings.vnet_resource_group_name)) > 0, false)
    error_message = format("Invalid value '%s' for variable 'network_settings.vnet_resource_group_name', it must be a non-empty string.", coalesce(var.network_settings.vnet_resource_group_name, "null"))
  }

  validation {
    condition     = try(length(trimspace(var.network_settings.subnet_name)) > 0, false)
    error_message = format("Invalid value '%s' for variable 'network_settings.subnet_name', it must be a non-empty string.", coalesce(var.network_settings.subnet_name, "null"))
  }
}

variable "managed_identity_settings" {
  description = "Settings related to the app gateway managed identity used to retrieve SSL certificates."
  type = object({
    name                = string
    resource_group_name = string
  })
  nullable = false

  validation {
    condition     = try(length(trimspace(var.managed_identity_settings.name)) > 0, false)
    error_message = format("Invalid value '%s' for variable 'managed_identity_settings.name', it must be a non-empty string.", coalesce(var.managed_identity_settings.name, "null"))
  }

  validation {
    condition     = try(length(trimspace(var.managed_identity_settings.resource_group_name)) > 0, false)
    error_message = format("Invalid value '%s' for variable 'managed_identity_settings.resource_group_name', it must be a non-empty string.", coalesce(var.managed_identity_settings.resource_group_name, "null"))
  }
}

variable "ssl_certificates" {
  description = "Settings related to SSL certificates that will be installed in the application gateway."
  type = list(object({
    name                          = string
    key_vault_name                = string
    key_vault_resource_group_name = string
    key_vault_certificate_name    = string
  }))
  default  = []
  nullable = false
}

variable "min_instance_count" {
  description = "The minimum number of instances the application gateway will have."
  type        = number
  default     = 2
  nullable    = false

  validation {
    condition     = var.min_instance_count >= 1 && var.min_instance_count <= 100
    error_message = format("Invalid value '%s' for variable 'min_instance_count', it must be between 1 and 100.", var.min_instance_count)
  }
}

variable "max_instance_count" {
  description = "The maximum number of instances the application gateway will have."
  type        = number
  default     = 10
  nullable    = false

  validation {
    condition     = var.max_instance_count >= 1 && var.max_instance_count <= 100
    error_message = format("Invalid value '%s' for variable 'max_instance_count', it must be between 1 and 100.", var.max_instance_count)
  }
}
