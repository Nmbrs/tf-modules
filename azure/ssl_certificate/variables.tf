variable "resource_group_name" {
  type        = string
  description = "The name of an existing Resource Group."
}

variable "workload" {
  description = "The workload name of the SSL certificate."
  type        = string

  validation {
    condition     = !contains([var.workload], "_") && !contains([var.workload], ".")
    error_message = format("Invalid value '%s' for variable 'workload'. It must not contain '_' or '.'.", var.workload)
  }
}

variable "domain_name" {
  type        = string
  description = "The domain name for the SSL certificate."
}
