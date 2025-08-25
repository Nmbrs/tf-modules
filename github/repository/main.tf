resource "github_repository" "repo" {
  name                   = var.name
  description            = var.description
  visibility             = var.visibility
  has_discussions        = false
  has_downloads          = false
  has_issues             = false
  has_projects           = false
  has_wiki               = false
  allow_merge_commit     = true
  allow_rebase_merge     = false
  allow_squash_merge     = true
  allow_auto_merge       = false
  archive_on_destroy     = false
  auto_init              = false
  delete_branch_on_merge = var.branch_deletion_enabled
  vulnerability_alerts   = true
  # Topics are an empty list in favor of organization custom properties
  topics = []

  lifecycle {
    ignore_changes = [is_template, description]
  }
}

# repository metadata settings
resource "github_repository_custom_property" "purpose" {
  repository     = github_repository.repo.name
  property_name  = "purpose"
  property_type  = "single_select"
  property_value = [var.purpose]
}

resource "github_repository_custom_property" "owner" {
  repository     = github_repository.repo.name
  property_name  = "owner"
  property_type  = "single_select"
  property_value = [var.owner]
}

resource "github_repository_custom_property" "apply_rulesets" {
  repository     = github_repository.repo.name
  property_name  = "apply_rulesets"
  property_type  = "true_false"
  property_value = [var.rulesets_enabled]
}

resource "github_repository_custom_property" "small_team" {
  repository     = github_repository.repo.name
  property_name  = "small_team"
  property_type  = "true_false"
  property_value = [var.is_small_team]
}

# github action access configuration
resource "github_actions_repository_access_level" "organization_level" {
  access_level = "organization"
  repository   = github_repository.repo.name
}
