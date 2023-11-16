locals {
  app_gateway_name = "agw-${var.workload}-${var.environment}-${var.location}-${format("%03d", var.instance_count)}"

  public_ip_name = "pip-agw-${var.workload}-${var.environment}-${var.location}-${format("%03d", var.instance_count)}"

  http_frontend_port_name = "http-frontend-port"

  https_frontend_port_name = "https-frontend-port"

  cipher_suites = [
    // Needs triage
    "TLS_ECDHE_ECDSA_WITH_AES_128_GCM_SHA256",
    "TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384",
    "TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256",
    "TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384",
    "TLS_ECDHE_ECDSA_WITH_AES_128_CBC_SHA256",
    "TLS_ECDHE_ECDSA_WITH_AES_256_CBC_SHA384",
    "TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256",
    "TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384",
    "TLS_RSA_WITH_AES_128_CBC_SHA256",

    // Cloudflare + Custom V2
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

  ## Renaming redirect listeners using their fqdn hosts
  # wild cards will be replaced by the word "wildcard"
  # all dots will be replaced by underscore
  # any dots at the end of the naming are going to be removed
  redirect_url_names = [
    for redirect in var.redirect_url_settings : "${redirect.listener.protocol}-${replace(replace(replace(redirect.listener.fqdn, ".", "-"), "*", "wildcard"), "\\.$", "")}"
  ]

  redirect_listener_names = [
    for redirect in var.redirect_listener_settings : "${redirect.listener.protocol}-${replace(replace(replace(redirect.listener.fqdn, ".", "-"), "*", "wildcard"), "\\.$", "")}"
  ]

  application_names = [
    for application in var.application_backend_settings : "${application.listener.protocol}-${replace(replace(replace(application.listener.fqdn, ".", "-"), "*", "wildcard"), "\\.$", "")}"
  ]

  ## The application gateway needs a default listener, backend pool, backend settings
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
        fqdn     = "contoso.com"
        port     = 80
        protocol = "http"
        health_probe = {
          timeout_in_seconds             = 30
          evaluation_interval_in_seconds = 30
          unhealthy_treshold_count       = 3
          path                           = "/"
        }
      }
    }
  ]

}
