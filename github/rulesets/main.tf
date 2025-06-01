resource "github_organization_ruleset" "protect_all_main_branches" {
  count       = var.type == "protect_all_main_branches" ? 1 : 0
  name        = "Protect all main branches"
  target      = "branch"
  enforcement = "active"

  conditions {
    ref_name {
      include = ["~DEFAULT_BRANCH"]
      exclude = []
    }
    repository_name {
      include = var.protected_repositories
      exclude = var.excluded_repositories
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
    required_linear_history = true
    non_fast_forward        = true
    required_signatures     = false
  }


  dynamic "bypass_actors" {
    for_each = toset(var.bypass_teams)
    content {
      actor_id    = data.github_team.bypass_team[each.value].id
      actor_type  = "Team"
      bypass_mode = "always"
    }
  }
}
