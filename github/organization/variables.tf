variable "enterprise_name" {
  type = string
}

variable "name" {
  type = string
}

variable "description" {
  type = string
}

variable "display_name" {
  type = string
}


variable "billing_email" {
  type    = string
  default = ""
}

variable "rulesets_settings" {
  type = list(object({
    name                                         = string
    protected_branch_list                        = list(string)
    bypass_teams                                 = list(string)
    pull_request_required_approving_review_count = number
  }))
}
