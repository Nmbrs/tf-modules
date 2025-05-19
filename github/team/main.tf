# Add a team to the organization
resource "github_team" "team" {
  name                      = var.name
  description               = var.description
  create_default_maintainer = false
  privacy                   = "closed"
  parent_team_id            = var.parent_team != "" && var.parent_team != null ? data.github_team.parent_team[0].id : null 

}
