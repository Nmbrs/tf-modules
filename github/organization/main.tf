resource "github_enterprise_organization" "organization" {
  enterprise_id = data.github_enterprise.enterprise.id
  name          = var.organization_slug
  display_name  = var.display_name
  description   = "Organization created with terraform"
  billing_email = "jon@winteriscoming.com"
  admin_logins  = [
    "jon-snow"
  ]
}

resource "github_organization_settings" "settings" {
    billing_email = var.billing_email
    company = var.name
    blog =  var.url
    email = null
    twitter_username = null
    location = null
    name = null
    description = var.description
    has_organization_projects = true
    has_repository_projects = true
    default_repository_permission = "read"
    members_can_create_repositories = false
    members_can_create_public_repositories = false
    members_can_create_private_repositories = true
    members_can_create_internal_repositories = true
    members_can_create_pages = true
    members_can_create_public_pages = false
    members_can_create_private_pages = true
    members_can_fork_private_repositories = false
    web_commit_signoff_required = false
    advanced_security_enabled_for_new_repositories = false
    dependabot_alerts_enabled_for_new_repositories=  true
    dependabot_security_updates_enabled_for_new_repositories = true
    dependency_graph_enabled_for_new_repositories = true
    secret_scanning_enabled_for_new_repositories = false
    secret_scanning_push_protection_enabled_for_new_repositories = false
}

resource "github_organization_ruleset" "protect_all_main_branches" {
  name        = "Protect all main branches"
  target      = "branch"
  enforcement = "active"

  conditions {
    ref_name {
      include = ["~DEFAULT_BRANCH"]
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
