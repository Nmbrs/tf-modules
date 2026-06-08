locals {
  sequence_suffix = var.sequence_number == null ? "" : "-${format("%03d", var.sequence_number)}"

  sql_server_name = (
    var.override_name != null ?
    lower(var.override_name) :
    lower("sqls-${var.company_prefix}-${var.workload}-${var.environment}-${var.location}${local.sequence_suffix}")
  )

  auditing_enabled = var.auditing_settings != null

  private_endpoint_subresources = ["sqlServer"]

  parsed_allowed_subnets = [
    for id in var.firewall_settings.allowed_subnet_ids : {
      id          = id
      subnet_name = regex("/subnets/([^/]+)$", id)[0]
      vnet_name   = regex("/virtualNetworks/([^/]+)/", id)[0]
    }
  ]

  vnet_rules = var.firewall_settings.public_network_access_enabled ? {
    for s in local.parsed_allowed_subnets :
    "${s.vnet_name}/${s.subnet_name}" => {
      name      = s.subnet_name
      subnet_id = s.id
    }
  } : {}
}
