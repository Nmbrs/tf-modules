variable "workload" {
  description = "The name of the workload associated with the resource."
  type        = string
}

variable "resource_group_name" {
  type        = string
  description = "The name of an existing Resource Group."
}

variable "naming_count" {
  description = "A numeric sequence number used for naming the resource. It ensures a unique identifier for each resource instance within the naming convention."
  type        = number

  validation {
    condition     = var.naming_count >= 1 && var.naming_count <= 999
    error_message = format("Invalid value '%s' for variable 'naming_count'. It must be between 1 and 999.", var.naming_count)
  }
}

variable "environment" {
  description = "The environment in which the resource should be provisioned."
  type        = string
}

variable "location" {
  description = "The location where the resources will be deployed in Azure. For an exaustive list of locations, please use the command 'az account list-locations -o table'."
  type        = string
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
