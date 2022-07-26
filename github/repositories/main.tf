module "github_repository" {
  source                 = "mineiros-io/repository/github"
  version                = "~> 0.16.0"
  
  for_each               = { for repository in var.repositories : repository.name => repository }
  name                   = each.value.name
  description            = each.value.description
  visibility             = each.value.visibility
  has_issues             = true
  has_projects           = true
  has_wiki               = false
  allow_merge_commit     = false
  allow_rebase_merge     = false
  allow_squash_merge     = true
  allow_auto_merge       = false
  has_downloads          = false
  auto_init              = true
  delete_branch_on_merge = true
  license_template       = "mit"
  topics                 = [each.value.squad]
  vulnerability_alerts   = true

  template = {
    owner      = var.github_owner
    repository = each.value.template
  }

  branch_protections_v3 = [
    {
      branch                          = "main"
      enforce_admins                  = true
      require_conversation_resolution = true
      require_status_check = {
        strict = true
      }

      required_pull_request_reviews = {
        dismiss_stale_reviews           = true
        require_code_owner_reviews      = true
        required_approving_review_count = 1
      }
    }
  ]
}
