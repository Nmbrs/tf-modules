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

  service_plan_name = "asp-${var.service_plan_name}-n${var.node_number}-${var.country}-${var.environment}"

  app_service_names = [
    for app_name in var.app_service_names : "as-${app_name}-n${var.node_number}-${var.country}-${var.environment}"
  ]
}
