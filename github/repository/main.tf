resource "github_repository" "repo" {
  name                   = var.name
  description            = var.description
  visibility             = var.visibility
  has_discussions        = true
  has_issues             = false
  has_projects           = false
  has_wiki               = false
  allow_merge_commit     = false
  allow_rebase_merge     = false
  allow_squash_merge     = true
  allow_auto_merge       = false
  archive_on_destroy     = false
  has_downloads          = false
  auto_init              = true
  delete_branch_on_merge = true
  vulnerability_alerts   = true
}

# repository metadata settings
resource "github_repository_custom_property" "purpose" {
  repository     = github_repository.repo.name
  property_name  = "purpose"
  property_type  = "single_select"
  property_value = [var.purpose]
}

# github action access configuration
resource "github_actions_repository_access_level" "organization_level" {
  access_level = "organization"
  repository   = github_repository.repo.name
}
