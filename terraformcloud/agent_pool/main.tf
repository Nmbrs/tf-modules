resource "tfe_agent_pool" "test-agent-pool" {
  name                = var.name
  organization        = var.organization_name
  organization_scoped = true
}
