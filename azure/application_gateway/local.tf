locals {
  app_gateway_name = "agw-${var.workload}-${var.environment}-${var.location}-${format("%03d", var.instance_count)}"

  public_ip_name = "pip-agw-${var.workload}-${var.environment}-${var.location}-${format("%03d", var.instance_count)}"

  http_frontend_port_name = "http-frontend-port"

  https_frontend_port_name = "https-frontend-port"

  cipher_suites = [
    # Note: When selecting the "Customv2" TLS policy, please be aware that  the ciphers "TLS_AES_128_GCM_SHA256" and "TLS_AES_256_GCM_SHA384" 
    # should not need to be explicitly included in the cipher list. These ciphers are automatically incorporated by Azure as they are mandatory for TLS v1.3, as per RFC 7539.
    "TLS_ECDHE_ECDSA_WITH_AES_128_GCM_SHA256",
    "TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384",
    "TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256",
    "TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384",
    "TLS_ECDHE_ECDSA_WITH_AES_128_CBC_SHA256",
    "TLS_ECDHE_ECDSA_WITH_AES_256_CBC_SHA384",
    "TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256",
    "TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384",
  ]

  new_cipher_suites = [
    // Needs triage
    "TLS_ECDHE_ECDSA_WITH_AES_128_GCM_SHA256",
    "TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384",
    "TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256",
    "TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384",
    "TLS_ECDHE_ECDSA_WITH_AES_128_CBC_SHA256",
    "TLS_ECDHE_ECDSA_WITH_AES_256_CBC_SHA384",
    "TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256",
    "TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384",

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


  cloud_flare_recomendations = [
    "ECDHE_ECDSA_WITH_AES_128_GCM_SHA256",
    "ECDHE_RSA_WITH_AES_128_GCM_SHA256",
    "ECDHE_ECDSA_WITH_AES_256_GCM_SHA384",
    "ECDHE_RSA_WITH_AES_256_GCM_SHA384",
    "ECDHE_ECDSA_WITH_AES_128_SHA256",
    "ECDHE_RSA_WITH_AES_128_SHA256",
    "ECDHE_ECDSA_WITH_AES_256_SHA384",
    "ECDHE_RSA_WITH_AES_256_SHA384"
  ]


  ## Renaming redirect listeners using their fqdn hosts
  # wild cards will be replaced by the word "wildcard"
  # all dots will be replaced by underscore
  # any dots at the end of the naming are going to be removed
  redirect_transformed_names = [
    for redirect in var.redirect_settings : "${redirect.protocol}-${replace(replace(replace(redirect.listener_fqdn, ".", "-"), "*.", "wildcard-"), "\\.$", "")}"
  ]
  application_transformed_names = [
    for application in var.application_settings : "${application.protocol}-${replace(replace(replace(application.listener_fqdn, ".", "-"), "*.", "wildcard-"), "\\.$", "")}"
  ]

  ## The application gateway needs a default listener, backend pool, backend settings
  default_settings = [
    {
      listener_name = "listener-default"
      settings_name = "settings-default"
      rule_name     = "rule-default"
      backend_name  = "backend-default"
      listener_fqdn = "contoso.com"
      rule_priority = 20000
      protocol      = "http"
      port          = 80
    }
  ]

}
