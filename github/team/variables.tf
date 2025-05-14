variable "name" {
  type = string
}

variable "description" {
  type = string
}

variable "parent_team" {
  type = optional(string, null)
}
