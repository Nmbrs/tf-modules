resource "github_enterprise_organization" "main" {
  enterprise_id = data.github_enterprise.enterprise.id
  name          = var.name
  display_name  = var.display_name
  description   = var.description
  billing_email = var.billing_email # irrelevent as it will be ignored
  admin_logins  = []                # irrelevent as it will be ignored

  lifecycle {
    ignore_changes = [admin_logins, billing_email]
  }
}

resource "github_organization_ruleset" "organization" {
  for_each    = { for rule in var.rulesets_settings : rule.name => rule }
  name        = each.value.name
  target      = "branch"
  enforcement = "active"

  conditions {
    ref_name {
      include = each.value.protected_branch_list
      exclude = []
    }
    ## What we want to do in this rule is to apply it only to filtered repositories
    ## but it's not supported yet byt github modules so we will ignore this section in the lifecycle
    repository_name {
      include = ["~ALL"]
      exclude = []
    }
  }

  rules {
    update                  = false
    deletion                = true
    required_linear_history = false
    non_fast_forward        = true
    required_signatures     = false

    dynamic "pull_request" {
      for_each = each.value.pull_request_required_approving_review_count > 0 ? [true] : []
      content {
        dismiss_stale_reviews_on_push     = true
        require_code_owner_review         = true
        require_last_push_approval        = true
        required_approving_review_count   = each.value.pull_request_required_approving_review_count
        required_review_thread_resolution = true
      }
    }
  }


  dynamic "bypass_actors" {
    for_each = toset(each.value.bypass_teams)
    content {
      actor_id    = data.github_team.bypass_team[bypass_actors.value].id
      actor_type  = "Team"
      bypass_mode = "always"
    }
  }

  lifecycle {
    ignore_changes = all
    # ignore_changes = [
    #   conditions[0].repository_name
    # ]
  }
}

resource "github_actions_organization_permissions" "organization" {
  allowed_actions      = "selected"
  enabled_repositories = "all"

  allowed_actions_config {
    github_owned_allowed = true
    verified_allowed     = true
  }
}
