data "github_team" "parent_team" {
  count = var.parent_team != "" && var.parent_team != null ? 1 : 0
  slug  = var.parent_team
}
