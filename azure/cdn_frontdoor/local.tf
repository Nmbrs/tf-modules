locals {
  frontdoor_profile_name = lower("afd-${var.workload}-${var.environment}")

  sku_name = {
    Standard = "Standard_AzureFrontDoor"
    Premium  = "Premium_AzureFrontDoor"
  }

  origins = flatten([
    for endpoint in var.endpoints : [
      for fqdn in endpoint.origin_settings.fqdns :
      {
        associated_endpoint_name                    = endpoint.name
        fqdn                                        = fqdn
        path                                        = endpoint.origin_settings.path
        session_affinity_enabled                    = endpoint.origin_settings.session_affinity_enabled
      }
    ]
  ])

  custom_domains = flatten([
    for endpoint in var.endpoints : [
      for domain in endpoint.custom_domains :
      {
        fqdn = domain.fqnd
        dns_zone_name = domain.dns_zone_name
        dns_zone_resource_group_name = domain.dns_zone_resource_group_name
      
        associated_endpoint_name = endpoint.name
        
      }
    ]
  ])

    rules = flatten([
    for endpoint in var.endpoints : [
      for rule in endpoint.rules :
      {
        name = rule.name
        associated_endpoint_name = endpoint.name
        
      }
    ]
  ])
}
