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
    bypass_teams                                 = list(string)
    pull_request_dismiss_stale_reviews_on_push   = bool
    pull_request_required_approving_review_count = number
  }))
}
