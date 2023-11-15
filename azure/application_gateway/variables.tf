variable "workload" {
  description = "The workload destined for the app gateway"
  type        = string
}

variable "resource_group_name" {
  type        = string
  description = "The name of an existing Resource Group."
}

variable "instance_count" {
  description = "The number of the app gw in case you have more than one"
  type        = string
}

variable "environment" {
  description = "The environment in which the resource should be provisioned."
  type        = string
}

variable "location" {
  description = "The location where the resources will be deployed in Azure. For an exaustive list of locations, please use the command 'az account list-locations -o table'."
  type        = string
}

variable "application_settings" {
  description = "The values of the application that the application gateway will serve"
  type = list(object({
    listener_fqdn    = string
    backend_fqdn     = string
    rule_priority    = number
    protocol         = string
    certificate_name = optional(string, null)
    health_probe = object({
      timeout_in_seconds             = number
      evaluation_interval_in_seconds = number
      unhealthy_treshold_count       = number
      path                           = string
      port                           = number
      protocol                       = string
    })
  }))

  default = []
}

variable "redirect_settings" {
  description = "The values of the application that the application gateway will serve"
  type = list(object({
    listener_fqdn    = string
    target_url       = string
    rule_priority    = number
    protocol         = string
    certificate_name = optional(string, null)
  }))

  default = []
}

variable "network_settings" {
  type = object({
    vnet_name                = string
    vnet_resource_group_name = string
    subnet_name              = string
  })
}

variable "managed_identity_settings" {
  type = object({
    name                = string
    resource_group_name = string
  })

}

variable "certificates" {
  type = list(object({
    name                          = string
    key_vault_name                = string
    key_vault_resource_group_name = string
    key_vault_certificate_name    = string
  }))

  default = []

}

variable "min_instance_count" {
  description = "Minimum value of instances the application gateway will have"
  type        = number
  default     = 2
}

variable "max_instance_count" {
  description = "Maximum value of instances the application gateway will have"
  type        = number
  default     = 10
}
