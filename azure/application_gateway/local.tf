locals {
  # Application Gateway name: Must be unique within subscription
  # Format: agw-{company}-{workload}-{env}-{location}-{seq}
  app_gateway_name = (var.override_name != null ?
    lower(var.override_name) :
    lower("agw-${var.company_prefix}-${var.workload}-${var.environment}-${var.location}-${format("%03d", var.sequence_number)}")
  )

  public_ip_name = "pip-${local.app_gateway_name}"

  # DNS Label: Must be globally unique, Azure automatically appends region
  # Format: agw-{company}-{workload}-{env}-{seq} (location omitted to avoid redundancy)
  # Results in: agw-{company}-{workload}-{env}-{seq}.{location}.cloudapp.azure.com
  app_gateway_dns_label = (var.override_name != null ?
    lower(var.override_name) :
    lower("agw-${var.company_prefix}-${var.workload}-${var.environment}-${format("%03d", var.sequence_number)}")
  )
}

locals {
  cipher_suites = [
    "TLS_ECDHE_ECDSA_WITH_AES_128_GCM_SHA256",
    "TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384",
    "TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256",
    "TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384",
    "TLS_ECDHE_ECDSA_WITH_AES_128_CBC_SHA256",
    "TLS_ECDHE_ECDSA_WITH_AES_256_CBC_SHA384",
    "TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256",
    "TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384",
    "TLS_RSA_WITH_AES_128_CBC_SHA256",
    "TLS_ECDHE_ECDSA_WITH_AES_128_CBC_SHA",
    "TLS_ECDHE_ECDSA_WITH_AES_256_CBC_SHA",
    "TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA",
    "TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA",
    "TLS_RSA_WITH_AES_256_GCM_SHA384",
    "TLS_RSA_WITH_AES_256_CBC_SHA",
    "TLS_RSA_WITH_AES_128_CBC_SHA",
    "TLS_RSA_WITH_AES_256_CBC_SHA256",
    "TLS_RSA_WITH_AES_128_GCM_SHA256",
    "TLS_DHE_RSA_WITH_AES_128_GCM_SHA256",
  ]

}

locals {
  # Application Gateway constants
  # Frontend port names
  http_frontend_port_name  = "http-frontend-port"
  https_frontend_port_name = "https-frontend-port"
  # Standard port numbers
  http_port  = 80
  https_port = 443
}

locals {
  # FQDN to resource name transformation
  # Transforms FQDNs to valid Azure resource names by:
  # - Replacing dots with hyphens
  # - Replacing wildcards (*) with "wildcard"
  # - Removing trailing dots
  # - Prefixing with protocol (http/https)
  redirect_url_names = [
    for redirect in var.redirect_url_settings : (
      "${redirect.listener.protocol}-${replace(replace(replace(redirect.listener.fqdn, ".", "-"), "*", "wildcard"), "\\.$", "")}"
    )
  ]

  redirect_listener_names = [
    for redirect in var.redirect_listener_settings : (
      "${redirect.listener.protocol}-${replace(replace(replace(redirect.listener.fqdn, ".", "-"), "*", "wildcard"), "\\.$", "")}"
    )
  ]

  application_names = length(var.application_backend_settings) != 0 ? [
    for application in var.application_backend_settings : (
      "${application.listener.protocol}-${replace(replace(replace(application.listener.fqdn, ".", "-"), "*", "wildcard"), "\\.$", "")}"
    )
    ] : [
    for application in local.default_application_settings : (
      "${application.listener.protocol}-${replace(replace(replace(application.listener.fqdn, ".", "-"), "*", "wildcard"), "\\.$", "")}"
    )
  ]
}

locals {
  # Priority values for routing rules (lower number = higher priority)
  default_priority = 20000 # Lowest priority for default/fallback rules

  # Health probe defaults
  default_health_probe_timeout_seconds             = 30
  default_health_probe_evaluation_interval_seconds = 30
  default_health_probe_unhealthy_threshold_count   = 3
  default_health_probe_success_status_codes        = ["200"]

  # Request timeout defaults
  default_request_timeout_seconds = 30

  # Default application settings
  # Required when no application_backend_settings are provided
  # Uses contoso.com as placeholder - will be replaced by actual settings
  default_application_settings = [
    {
      routing_rule = {
        priority = local.default_priority
      }
      listener = {
        fqdn     = "contoso.com"
        protocol = "http"
      }
      backend = {
        fqdns                         = ["contoso.com"]
        port                          = local.http_port
        protocol                      = "http"
        cookie_based_affinity_enabled = true
        request_timeout_in_seconds    = local.default_request_timeout_seconds
        health_probe = {
          timeout_in_seconds             = local.default_health_probe_timeout_seconds
          evaluation_interval_in_seconds = local.default_health_probe_evaluation_interval_seconds
          unhealthy_treshold_count       = local.default_health_probe_unhealthy_threshold_count
          fqdn                           = "contoso.com"
          path                           = "/"
          status_codes                   = local.default_health_probe_success_status_codes
        }
      }
    }
  ]
}
