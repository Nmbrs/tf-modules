data "github_team" "admin" {
  slug = var.admin_team
}

data "github_user" "admin" {
  username = var.admin_username
}