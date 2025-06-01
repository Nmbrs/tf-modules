data "github_enterprise" "example" {
  slug = var.enterprise_name
}

data "github_team" "protect_all_main_branches_bypass_team" {
  for_each = toset(var.var.rulesets_settings.protect_all_main_branches.bypass_teams)
  slug     = each.value
}
