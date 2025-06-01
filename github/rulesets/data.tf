data "github_team" "bypass_team" {
  for_each = toset(var.bypass_teams)
  slug     = each.value
}
