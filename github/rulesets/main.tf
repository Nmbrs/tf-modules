resource "github_organization_ruleset" "protect_all_main_branches" {
  name        = "Protect all main branches"
  target      = "branch"
  enforcement = "active"

  conditions {
    ref_name {
      include = ["refs/heads/main"]
      exclude = []
    }

    repository_name {
      include = ["~ALL"]
      exclude = []
    }
  }

  rules {
    creation                = true
    update                  = true
    deletion                = true
    required_linear_history = true
    pull_request {
      required_approving_review_count = 2
    }
  }

  bypass_actors {
    actor_id    = data.github_user.admin.id
    actor_type  = "OrganizationAdmin"
    bypass_mode = "always"
  }
}
