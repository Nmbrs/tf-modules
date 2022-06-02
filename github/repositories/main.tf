resource "github_repository" "repo" {
  for_each    = var.repos
  name        = each.value["name"]
  description = each.value["description"]
  visibility  = each.value["visibility"]

  template {
    owner      = "nmbrs"
    repository = each.value["repo_template"]
  }
}

