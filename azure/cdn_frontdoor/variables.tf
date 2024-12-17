variable "workload" {
  description = "The name of the workload associated with the resource."
  type        = string
}

variable "resource_group_name" {
  type        = string
  description = "The name of an existing Resource Group."
}

variable "environment" {
  description = "The environment in which the resource should be provisioned."
  type        = string
}

variable "sku_name" {
  description = "Configuration of the size and capacity of the logspace analytics."
  type        = string

  validation {
    condition     = contains(["Standard", "Premium"], var.sku_name)
    error_message = format("Invalid value '%s' for variable 'sku_name', valid options are 'Standard', 'Premium'.", var.sku_name)
  }
}

variable "response_timeout_seconds" {
  description = "The timeout period, in seconds, for responses. This value must be between 10 and 20 seconds."
  type        = number
  default     = 60

  validation {
    condition     = var.response_timeout_seconds >= 16 && var.response_timeout_seconds <= 240
    error_message = format("Invalid value '%s' for variable 'response_timeout_seconds', valid values are between 16 and 240 '.", var.response_timeout_seconds)
  }
}
variable "endpoints" {
  description = "A list of frontdoor endpoints."
  type = list(object({
    name = string
    origin_settings = object({
      fqdns                    = list(string)
      http_port                = number
      https_port               = number
      session_affinity_enabled = bool
      #request_timeout_in_seconds = optional(number, 30)
      health_probe = object({
        protocol = string
        #timeout_in_seconds             = number
        evaluation_interval_in_seconds = number
        #unhealthy_treshold_count       = number
        path = string
        #status_codes                   = list(string)
      })
    })
  }))

  default = []
}
