resource "github_organization_ruleset" "protect_all_main_branches" {
  name        = "Protect all main branches"
  target      = "branch"
  enforcement = "active"

  conditions {
    ref_name {
      include = ["refs/heads/main", "refs/heads/master"]
      exclude = []
    }

    repository_name {
      include = ["~ALL"] #check if we should use patterns for the repo names, to not block everything
      exclude = []
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

  bypass_actors {
    actor_id    = data.github_team.admin.id
    actor_type  = "Team"
    bypass_mode = "always"
  }
}
