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
        fqdn                                        = fqdn
        endpoint_name                               = endpoint.name
        path                                        = endpoint.origin_settings.path
        http_port                                   = endpoint.origin_settings.http_port
        https_port                                  = endpoint.origin_settings.https_port
        session_affinity_enabled                    = endpoint.origin_settings.session_affinity_enabled
        health_probe_protocol                       = title(endpoint.origin_settings.health_probe.protocol)
        health_probe_path                           = endpoint.origin_settings.health_probe.path
        health_probe_evaluation_interval_in_seconds = endpoint.origin_settings.health_probe.evaluation_interval_in_seconds
      }
    ]
  ])

  custom_domain = flatten([
    for endpoint in var.endpoints : [
      for domain in endpoint.custom_domains :
      {
        name = domain
        associated_endpoint_name = endpoint.name
        
      }
    ]
  ])
}
