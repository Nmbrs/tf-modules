variable "name" {
  description = "The name of the metric alert"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group in which to create the metric alert"
  type        = string
}

variable "scopes" {
  description = "A set of strings representing the resource IDs to scope the metric alert to"
  type        = list(string)
}

variable "description" {
  description = "The description of the metric alert"
  type        = string
  default     = null
}

variable "severity" {
  description = "The severity of the metric alert. Possible values are 0 (Critical), 1 (Error), 2 (Warning), 3 (Informational), 4 (Verbose)"
  type        = number
  default     = 2

  validation {
    condition     = contains([0, 1, 2, 3, 4], var.severity)
    error_message = "Severity must be one of: 0, 1, 2, 3, 4"
  }
}

variable "enabled" {
  description = "Should this metric alert be enabled?"
  type        = bool
  default     = true
}

variable "auto_mitigate" {
  description = "Should the alert auto resolve?"
  type        = bool
  default     = true
}

variable "frequency" {
  description = "The evaluation frequency of the metric alert, in ISO 8601 duration format. Possible values: PT1M, PT5M, PT15M, PT30M, PT1H"
  type        = string
  default     = "PT5M"
}

variable "window_size" {
  description = "The period of time that is used to monitor alert activity, in ISO 8601 duration format. Possible values: PT1M, PT5M, PT15M, PT30M, PT1H, PT6H, PT12H, PT24H"
  type        = string
  default     = "PT15M"
}

variable "criteria" {
  description = "The criteria for the metric alert"
  type = object({
    metric_namespace = string
    metric_name      = string
    aggregation      = string
    operator         = string
    threshold        = number
    dimensions = optional(list(object({
      name     = string
      operator = string
      values   = list(string)
    })))
  })
}

variable "action_group_ids" {
  description = "The list of action group IDs to trigger when the alert fires"
  type        = list(string)
  default     = []
}

variable "tags" {
  description = "A mapping of tags to assign to the resource"
  type        = map(string)
  default     = null
}
