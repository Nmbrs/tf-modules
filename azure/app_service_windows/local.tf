locals {
  app_stack = {
    "dotnet:7"             = "dotnet"
    "dotnet:6"             = "dotnet"
    "ASPNET:V4.8"          = "dotnet"
    "ASPNET:V3.5"          = "dotnet"
    "NODE:18LTS"           = "node"
    "NODE:16LTS"           = "node"
    "NODE:14LTS"           = "node"
    "java:1.8:Java SE:8"   = "java"
    "java:11:Java SE:11"   = "java"
    "java:17:Java SE:17"   = "java"
    "java:1.8:TOMCAT:10.0" = "java"
    "java:11:TOMCAT:10.0"  = "java"
    "java:17:TOMCAT:10.0"  = "java"
    "java:1.8:TOMCAT:9.0"  = "java"
    "java:11:TOMCAT:9.0"   = "java"
    "java:17:TOMCAT:9.0"   = "java"
    "java:1.8:TOMCAT:8.5"  = "java"
    "java:11:TOMCAT:8.5"   = "java"
    "java:17:TOMCAT:8.5"   = "java"
  }

  custom_domains = flatten([
    for app in var.app_services : [
      for custom_domain in app.custom_domains :
      {
        app_short_name             = app.name
        app_full_name              = "as-${var.service_plan_name}-${app.name}-${var.environment}"
        fqdn                       = "${custom_domain.cname_record_name}.${custom_domain.dns_zone_name}"
        cname_record_name          = custom_domain.cname_record_name
        dns_zone_name              = custom_domain.dns_zone_name
        dns_zone_resource_group    = custom_domain.dns_zone_resource_group
        certificate_name           = custom_domain.certificate_name
        certificate_resource_group = custom_domain.certificate_resource_group
        key_vault_name             = custom_domain.key_vault_name
        key_vault_secret_name      = custom_domain.key_vault_secret_name
      }
    ]
  ])
}
