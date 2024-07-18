resource "azurerm_container_app" "example" {
  container_app_environment_id = "/subscriptions/0abe1f07-d2a2-4c7a-a36c-9e91baa7321d/resourceGroups/rg-aca-dev/providers/Microsoft.App/managedEnvironments/microservices-001"

  name                = "ca-reporting-dev"
  resource_group_name = "rg-reporting-dev"
  revision_mode       = "Single"
  tags = {
    "category"    = "microservices_platform"
    "country"     = "global"
    "created_at"  = "2024-03-18T14:36:20.6304042Z"
    "environment" = "dev"
    "managed_by"  = "terraform"
    "owner"       = "core"
    "status"      = "life_cycle"
  }

  identity {
    identity_ids = [
      "/subscriptions/0abe1f07-d2a2-4c7a-a36c-9e91baa7321d/resourceGroups/rg-reporting-dev/providers/Microsoft.ManagedIdentity/userAssignedIdentities/mi-reporting-dev",
    ]
    type = "UserAssigned"
  }

  ingress {
    allow_insecure_connections = false
    exposed_port               = 9100
    external_enabled           = true
    target_port                = 80
    transport                  = "auto"

    custom_domain {
      certificate_binding_type = "SniEnabled"
      certificate_id           = "/subscriptions/0abe1f07-d2a2-4c7a-a36c-9e91baa7321d/resourceGroups/rg-aca-dev/providers/Microsoft.App/managedEnvironments/microservices-001/certificates/wildcard-nmbrsapp-dev-com"
      name                     = "reporting-service.nmbrsapp-dev.com"
    }

    traffic_weight {
      latest_revision = true
      percentage      = 100
    }
  }

  registry {
    password_secret_name = "nmbrsazurecrio-nmbrs"
    server               = "nmbrs.azurecr.io"
    username             = "nmbrs"
  }

  template {
    max_replicas = 10
    min_replicas = 1

    container {
      args    = []
      command = []
      cpu     = 1
      image   = "nmbrs.azurecr.io/nmbrs/reporting:container_migration6"
      memory  = "2Gi"
      name    = "reporting"

      env {
        name  = "AZURE_APPCONFIGURATION_ENDPOINT"
        value = "https://ac-nmbrs-kitchen.azconfig.io"
      }
      env {
        name  = "AZURE_CLIENT_ID"
        value = "3f3998f2-3515-4f90-b178-d0dffbd6fb11"
      }
      env {
        name  = "ASPNETCORE_ENVIRONMENT"
        value = "Kitchen"
      }
      env {
        name  = "APPLICATIONINSIGHTS_CONNECTION_STRING"
        value = "InstrumentationKey=c093a82e-3875-4cc0-8f4c-f1d6da0816f9;IngestionEndpoint=https://westeurope-5.in.applicationinsights.azure.com/;LiveEndpoint=https://westeurope.livediagnostics.monitor.azure.com/"
      }
    }

    custom_scale_rule {
      custom_rule_type = "cpu"
      metadata = {
        "type"  = "Utilization"
        "value" = "75"
      }
      name = "cpu-autoscaling"
    }
    custom_scale_rule {
      custom_rule_type = "memory"
      metadata = {
        "type"  = "Utilization"
        "value" = "75"
      }
      name = "mem-autoscaling"
    }

    http_scale_rule {
      concurrent_requests = "50"
      name                = "http-autoscaling"
    }
  }

  lifecycle {
    ignore_changes = [tags, secret, ingress, registry, template]
  }
}

## Location module
module "cae" {
  source              = "/Users/filipe/repositories/nmbrs/tf-modules/azure/container_app"
  workload            = "filipe"
  resource_group_name = "rg-reporting-dev"
  environment         = "dev"
  location            = "westeurope"
  managed_identity_settings = {
    name                = "mi-reporting-dev"
    resource_group_name = "rg-reporting-dev"
  }
  container_app_environment_settings = {
    name                = "microservices-001"
    resource_group_name = "rg-aca-dev"
  }
}

module "container_app_environment" {
  source              = "./azure/container_app_environment"
  workload            = "myworkload"
  resource_group_name = module.resource_group_vnet_001.name
  environment         = module.environment.name
  location            = module.location.name
  network_settings = {
    subnet_name              = "snet-caedemo"
    vnet_name                = module.vnet_001.name
    vnet_resource_group_name = module.resource_group_vnet_001.name
  }
  log_analytics_worspace_settings = {
    resource_group_name = module.resource_group_vnet_001.name
    name                = "wsp-myworkload-dev"
  }
}

# module "container_app_environment_demo" {
#   source              = "./azure/container_app_env"
#   workload            = "myworkload"
#   resource_group_name = module.resource_group_vnet_001.name
#   environment         = module.environment.name
#   location            = module.location.name
#   network_settings = {
#     subnet_name              = "snet-containerapp"
#     vnet_name                = module.vnet_001.name
#     vnet_resource_group_name = module.resource_group_vnet_001.name
#   }
# }