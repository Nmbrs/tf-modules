# resource "github_organization_settings" "settings" {
#     billing_email = var.billing_email
#     company = var.name
#     blog =  var.url
#     email = null
#     twitter_username = null
#     location = null
#     name = null
#     description = var.description
#     has_organization_projects = true
#     has_repository_projects = true
#     default_repository_permission = "read"
#     members_can_create_repositories = false
#     members_can_create_public_repositories = false
#     members_can_create_private_repositories = true
#     members_can_create_internal_repositories = true
#     members_can_create_pages = true
#     members_can_create_public_pages = false
#     members_can_create_private_pages = true
#     members_can_fork_private_repositories = false
#     web_commit_signoff_required = false
#     advanced_security_enabled_for_new_repositories = false
#     dependabot_alerts_enabled_for_new_repositories=  true
#     dependabot_security_updates_enabled_for_new_repositories = true
#     dependency_graph_enabled_for_new_repositories = true
#     secret_scanning_enabled_for_new_repositories = false
#     secret_scanning_push_protection_enabled_for_new_repositories = false
# }