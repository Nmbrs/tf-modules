locals {
  # Application Gateway name: Must be unique within subscription
  # Format: agw-{company}-{workload}-{env}-{location}-{seq}
  app_gateway_name = (var.override_name != null && var.override_name != "" ?
    lower(var.override_name) :
    lower("agw-${var.company_prefix}-${var.workload}-${var.environment}-${var.location}-${format("%03d", var.sequence_number)}")
  )

  # DNS Label: Must be globally unique, Azure automatically appends region
  # Format: agw-{company}-{workload}-{env}-{seq} (location omitted to avoid redundancy)
  # Results in: agw-{company}-{workload}-{env}-{seq}.{location}.cloudapp.azure.com
  app_gateway_dns_label = (var.override_name != null && var.override_name != "" ?
    lower(var.override_name) :
    lower("agw-${var.company_prefix}-${var.workload}-${var.environment}-${format("%03d", var.sequence_number)}")
  )

  # Frontend port names
  http_frontend_port_name  = "http-frontend-port"
  https_frontend_port_name = "https-frontend-port"

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

  # Default application settings
  # Required when no application_backend_settings are provided
  # Uses contoso.com as placeholder - will be replaced by actual settings
  default_application_settings = [
    {
      routing_rule = {
        priority = 20000
      }
      listener = {
        fqdn     = "contoso.com"
        protocol = "http"
      }
      backend = {
        fqdns                         = ["contoso.com"]
        port                          = 80
        protocol                      = "http"
        cookie_based_affinity_enabled = true
        request_timeout_in_seconds    = 30
        health_probe = {
          timeout_in_seconds             = 30
          evaluation_interval_in_seconds = 30
          unhealthy_treshold_count       = 3
          fqdn                           = "contoso.com"
          path                           = "/"
          status_codes                   = ["200"]
        }
      }
    }
  ]
}
