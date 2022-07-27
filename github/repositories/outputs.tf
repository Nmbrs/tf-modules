output "repositories" {
  description = "List of values github repositories"
  value = [
    for repository in module.github_repository : {
      name           = repository.repository.name
      visibility     = repository.repository.visibility
      html_url       = repository.html_url
      http_clone_url = repository.http_clone_url
      ssh_clone_url  = repository.ssh_clone_url
    }
  ]
}
