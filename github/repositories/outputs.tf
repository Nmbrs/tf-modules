output "repositories" {
  description = "List of github repositories with their details"
  value = [
    for repository in resource.github_repository.repo : {
      name                   = repository.name
      visibility             = repository.visibility
      html_url               = repository.html_url
      http_clone_url         = repository.http_clone_url
      ssh_clone_url          = repository.ssh_clone_url
      node_id                = repository.node_id
      delete_branch_on_merge = repository.delete_branch_on_merge
    }
  ]
}
