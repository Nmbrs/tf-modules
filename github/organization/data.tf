data "github_enterprise" "enterprise" {
  slug = var.enterprise_name
}

data "github_team" "bypass_team" {
  for_each = toset(flatten([for rule in var.rulesets_settings : rule.bypass_teams]))
  slug     = each.value
}
