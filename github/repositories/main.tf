resource "github_repository" "repo" {
  for_each               = { for repository in var.repositories : trimspace(lower(repository.name)) => repository }
  name                   = each.value.name
  description            = each.value.description
  visibility             = each.value.visibility
  has_issues             = false
  has_discussions        = true
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
  topics                 = [each.value.squad]
  vulnerability_alerts   = true

}
