data "github_enterprise" "enterprise" {
  slug = var.enterprise_name
}

data "github_team" "protect_default_branches_small_teams_bypass_team" {
  for_each = toset(var.rulesets_settings.protect_default_branches_small_teams.bypass_teams)
  slug     = each.value
}

data "github_team" "protect_default_branches_large_teams_bypass_team" {
  for_each = toset(var.rulesets_settings.protect_default_branches_large_teams.bypass_teams)
  slug     = each.value
}