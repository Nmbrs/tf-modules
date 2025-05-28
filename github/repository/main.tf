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
resource "github_repository_custom_property" "owner" {
  repository     = github_repository.repo.name
  property_name  = "owner"
  property_type  = "single_select"
  property_value = [var.owner]
}

resource "github_repository_custom_property" "internal" {
  repository     = github_repository.repo.name
  property_name  = "internal"
  property_type  = "true_false"
  property_value = [var.is_internal]
}

resource "github_repository_custom_property" "poc" {
  repository     = github_repository.repo.name
  property_name  = "poc"
  property_type  = "true_false"
  property_value = [var.is_poc]
}

resource "github_repository_custom_property" "tool" {
  repository     = github_repository.repo.name
  property_name  = "tool"
  property_type  = "true_false"
  property_value = [var.is_tool]
}

# github action access configuration
resource "github_actions_repository_access_level" "organization_level" {
  access_level = "organization"
  repository   = github_repository.repo.name
}
