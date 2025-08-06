resource "github_enterprise_organization" "organization" {
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

resource "github_organization_ruleset" "protect_default_branches_large_teams" {
  name        = "Protect default branches (large teams)"
  target      = "branch"
  enforcement = "active"

  conditions {
    ref_name {
      include = ["~DEFAULT_BRANCH"]
      exclude = []
    }
    ## What we want to do in this rule is to apply it only to filtered repositories
    ## but it's not supported yet byt github modules so we will ignore this section in the lifecycle
    repository_name {
      include = var.rulesets_settings.protect_default_branches_large_teams.protected_repositories
      exclude = var.rulesets_settings.protect_default_branches_large_teams.excluded_repositories
    }
  }

  rules {
    update   = false
    deletion = true
    pull_request {
      dismiss_stale_reviews_on_push     = true
      require_code_owner_review         = true
      require_last_push_approval        = true
      required_approving_review_count   = 2
      required_review_thread_resolution = true
    }
    required_linear_history = false
    non_fast_forward        = true
    required_signatures     = false
  }


  dynamic "bypass_actors" {
    for_each = toset(var.rulesets_settings.protect_default_branches_large_teams.bypass_teams)  
    content {
      actor_id    = data.github_team.protect_default_branches_large_teams_bypass_team[bypass_actors.value].id
      actor_type  = "Team"
      bypass_mode = "always"
    }
  }

  lifecycle {
    ignore_changes = [
      conditions[0].repository_name
    ]
  }
}

resource "github_organization_ruleset" "protect_default_branches_small_teams" {
  name        = "Protect default branches (small teams)"
  target      = "branch"
  enforcement = "active"

  conditions {
    ref_name {
      include = var.rulesets_settings.protect_default_branches_small_teams.branch_names
      exclude = []
    }
    ## What we want to do in this rule is to apply it only to filtered repositories
    ## but it's not supported yet byt github modules so we will ignore this section in the lifecycle
    repository_name {
      include = var.rulesets_settings.protect_default_branches_small_teams.protected_repositories
      exclude = var.rulesets_settings.protect_default_branches_small_teams.excluded_repositories
    }
  }

  rules {
    update   = false
    deletion = true
    pull_request {
      dismiss_stale_reviews_on_push     = true
      require_code_owner_review         = true
      require_last_push_approval        = true
      required_approving_review_count   = 1
      required_review_thread_resolution = true
    }
    required_linear_history = false
    non_fast_forward        = true
    required_signatures     = false
  }


  dynamic "bypass_actors" {
    for_each = toset(var.rulesets_settings.protect_default_branches_small_teams.bypass_teams)
    content {
      actor_id    = data.github_team.protect_default_branches_small_teams_bypass_team[bypass_actors.value].id
      actor_type  = "Team"
      bypass_mode = "always"
    }
  }

  lifecycle {
    ignore_changes = [
      conditions[0].repository_name
    ]
  }
}