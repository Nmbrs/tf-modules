variable "name" {
  description = "Name of the variable set."
  type        = string
}

variable "organization_name" {
  description = "Name of the organization."
  type        = string
}

variable "variable_sets" {
  description = "List of variable sets associated to the project."
  type        = list(string)
}
