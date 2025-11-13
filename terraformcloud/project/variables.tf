variable "name" {
  description = "Name of the project."
  type        = string
  nullable    = false
}

variable "organization_name" {
  description = "Name of the organization."
  type        = string
  nullable    = false
}

variable "associated_variable_sets" {
  description = "List of variable sets associated to the project."
  type        = list(string)
  nullable    = false
}

variable "associated_agent_pool" {
  description = "Name of the agent pool associated with the project. If not set, remote execution will be used."
  type        = string
  nullable    = true
  default     = null
}
