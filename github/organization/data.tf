data "github_enterprise" "enterprise" {
  slug = var.enterprise_name
}

data "github_team" "bypass_team" {
  for_each = { for rule in var.rulesets_settings : rule.name => rule }
  slug     = each.value
}
