output "name" {
  value = { for k, repo in github_repository.repo : k => repo.name }
}
