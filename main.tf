## Environment module
module "environment" {
  source      = "./general/environment"
  environment = var.environment
}

## Location module
module "location" {
  source   = "./azure/location"
  location = var.location
}

## Resource Group
module "resource_group_vnet_001" {
  source      = "./azure/resource_group"
  workload    = "tf-filipe-vnet-001"
  location    = module.location.name
  environment = module.environment.name
  tags = {
    environment = module.environment.name
    managed_by  = "terraform"
    product     = var.product
    category    = var.category
    owner       = var.owner
    country     = var.country
    status      = var.status
    service     = "pr"
  }
}

# Virtual Networks
module "vnet_001" {
  source              = "./azure/virtual_network"
  resource_group_name = module.resource_group_vnet_001.name
  workload            = "tfsample"
  #name = "vnet-tfsample-dev-westeurope-900"
  naming_count   = 900
  address_spaces = ["10.90.0.0/16"]
  environment    = module.environment.name
  location       = module.location.name
  subnets = [
    {
      name                                          = "snet-appservicesmonolith-001"
      address_prefixes                              = ["10.90.10.0/24"]
      private_link_service_network_policies_enabled = false
      private_endpoint_network_policies_enabled     = false
      service_endpoints                             = []
      delegations                                   = ["Microsoft.Web/serverFarms"]
    },
    {
      name                                          = "snet-appservicesmonolith-002"
      address_prefixes                              = ["10.90.11.0/24"]
      private_link_service_network_policies_enabled = false
      private_endpoint_network_policies_enabled     = false
      service_endpoints                             = []
      delegations                                   = ["Microsoft.Web/serverFarms"]
    },
    {
      name                                          = "snet-appservicesmonolith-003"
      address_prefixes                              = ["10.90.12.0/24"]
      private_link_service_network_policies_enabled = false
      private_endpoint_network_policies_enabled     = false
      service_endpoints                             = []
      delegations                                   = ["Microsoft.Web/serverFarms"]
    },
    {
      name                                          = "snet-natgateway-001"
      address_prefixes                              = ["10.90.13.0/24"]
      private_link_service_network_policies_enabled = false
      private_endpoint_network_policies_enabled     = false
      service_endpoints                             = []
      delegations                                   = []
    },
    {
      name                                          = "snet-inboundprivatedns-dev-westeurope-001"
      address_prefixes                              = ["10.90.14.0/24"]
      private_link_service_network_policies_enabled = true
      private_endpoint_network_policies_enabled     = false
      service_endpoints                             = []
      delegations                                   = ["Microsoft.Network/dnsResolvers"]
    },
    {
      name                                          = "snet-outboundprivatedns-dev-westeurope-001"
      address_prefixes                              = ["10.90.15.0/24"]
      private_link_service_network_policies_enabled = true
      private_endpoint_network_policies_enabled     = false
      service_endpoints                             = []
      delegations                                   = ["Microsoft.Network/dnsResolvers"]
    },
    {
      name                                          = "snet-appgateway-001"
      address_prefixes                              = ["10.90.16.0/24"]
      private_link_service_network_policies_enabled = true
      private_endpoint_network_policies_enabled     = false
      service_endpoints                             = []
      delegations                                   = []
    },
    {
      name                                          = "GatewaySubnet"
      address_prefixes                              = ["10.90.17.0/24"]
      private_link_service_network_policies_enabled = false
      private_endpoint_network_policies_enabled     = false
      service_endpoints                             = []
      delegations                                   = []
    },
    {
      name                                          = "snet-divgateway-001"
      address_prefixes                              = ["10.90.78.0/24"]
      private_link_service_network_policies_enabled = true
      private_endpoint_network_policies_enabled     = false
      service_endpoints                             = []
      delegations                                   = []
    },
    {
      name                                          = "snet-caedemo"
      address_prefixes                              = ["10.90.20.0/23"]
      private_link_service_network_policies_enabled = true
      private_endpoint_network_policies_enabled     = false
      service_endpoints                             = []
      delegations                                   = []
    },
    {
      name                                          = "snet-containerapp"
      address_prefixes                              = ["10.90.22.0/23"]
      private_link_service_network_policies_enabled = true
      private_endpoint_network_policies_enabled     = false
      service_endpoints                             = []
      delegations                                   = []
    },
  ]
}

module "managed_identity" {
  source              = "./azure/managed_identity"
  workload            = "azure-devops-filipe"
  resource_group_name = module.resource_group_vnet_001.name
  environment         = module.environment.name
  location            = module.location.name
}

# module "managed_identity" {
#   source              = "./azure/managed_identity"
#   workload            = "appgateway"
#   resource_group_name = module.resource_group_vnet_001.name
#   environment         = module.environment.name
#   location            = module.location.name
# }

## Key Vault
# module "key_vault" {
#   source   = "git::github.com/Nmbrs/tf-modules//azure/key_vault?ref=main"
#   workload                = "appgwfilipe"
#   resource_group_name = module.resource_group_vnet_001.name
#   external_usage      = true
#   environment         = "dev"
#   location            = "westeurope"
#   policies = [
#     {
#       name      = "my-mi"
#       type      = "readers"
#       object_id = "65fded55-bf02-489e-b1ab-32eaba98b296"
#     },
#   ]
# }


## Key Vault
# module "key_vault_no_caf" {
#   source              = "./azure/key_vault"
#   #workload                = "bigbigbigbigname"
#   workload                = "short123"
#   resource_group_name = module.resource_group_vnet_001.name
#   external_usage      = true
#   environment         = "prod"
#   location            = "westeurope"
#   policies = [
#     {
#       name      = "my-mi"
#       type      = "readers"
#       object_id = "65fded55-bf02-489e-b1ab-32eaba98b296"
#     },
#   ]
# }

## App gateway
# module "application_gateway" {
#   source              = "./azure/application_gateway"
#   workload            = "tfshared"
#   resource_group_name = module.resource_group_vnet_001.name 
#   naming_count        = 1
#   environment         = module.environment.name
#   location            = module.location.name
#   min_instance_count  = "2"
#   max_instance_count  = "10"

#   network_settings = {
#     vnet_name                = module.vnet_001.name
#     vnet_resource_group_name = module.resource_group_vnet_001.name
#     subnet_name              = "snet-appgateway-001"
#   }

#   managed_identity_settings = {
#     name                = module.managed_identity.name
#     resource_group_name = module.resource_group_vnet_001.name
#   }

#   ssl_certificates = [
#     {
#       key_vault_resource_group_name = module.resource_group_vnet_001.name
#       key_vault_name                = "kv-nmbrs-appgwfilipe-e"
#       key_vault_certificate_name    = "wildcard-nmbrs-se"
#       name                          = "nmbrs-se"
#     },
#     {
#       key_vault_resource_group_name = module.resource_group_vnet_001.name
#       key_vault_name                = "kv-nmbrs-appgwfilipe-e"
#       key_vault_certificate_name    = "wildcard-nmbrs-nl"
#       name                          = "nmbrs-nl"
#     },
#     {
#       key_vault_resource_group_name = module.resource_group_vnet_001.name
#       key_vault_name                = "kv-nmbrs-appgwfilipe-e"
#       key_vault_certificate_name    = "wildcard-nmbrs-test-se"
#       name                          = "nmbrs-test-se"
#     },
#     {
#       key_vault_resource_group_name = module.resource_group_vnet_001.name
#       key_vault_name                = "kv-nmbrs-appgwfilipe-e"
#       key_vault_certificate_name    = "wildcard-nmbrs-test-nl"
#       name                          = "nmbrs-test-nl"
#     },
#     {
#       key_vault_resource_group_name = module.resource_group_vnet_001.name
#       key_vault_name                = "kv-nmbrs-appgwfilipe-e"
#       key_vault_certificate_name    = "wildcard-nmbrs-com"
#       name                          = "nmbrs-com"
#     }
#   ]

#   application_backend_settings = [
#     ## nmbrs.nl entries
#     ## *.nmbrs.nl
#     # {
#     #   routing_rule = {
#     #     priority = 100
#     #   }
#     #   listener = {
#     #     fqdn             = "*.nmbrs.nl"
#     #     protocol         = "https"
#     #     certificate_name = "nmbrs-nl"
#     #   }
#     #   backend = {
#     #     fqdns                         = ["as-web-n1-test-nl.azurewebsites.net", "as-monolith-web-n2-nl-test.azurewebsites.net"]
#     #     port                          = 443
#     #     protocol                      = "https"
#     #     cookie_based_affinity_enabled = false
#     #     request_timeout_in_seconds    = 30
#     #     health_probe = {
#     #       fqdn                           = "admin.nmbrs.nl"
#     #       timeout_in_seconds             = 30
#     #       evaluation_interval_in_seconds = 30
#     #       unhealthy_treshold_count       = 3
#     #       path                           = "/"
#     #       status_codes                   = ["200-599"]
#     #     }
#     #   }
#     # },
#     ## filipe.nmbrs.nl
#     # {
#     #   routing_rule = {
#     #     priority = 1
#     #   }
#     #   listener = {
#     #     fqdn             = "filipe.nmbrs.nl"
#     #     protocol         = "https"
#     #     certificate_name = "nmbrs-nl"
#     #   }
#     #   backend = {
#     #     fqdns                         = ["ffsterraform.azurewebsites.net"]
#     #     port                          = 443
#     #     protocol                      = "https"
#     #     cookie_based_affinity_enabled = false
#     #     request_timeout_in_seconds    = 30
#     #     health_probe = {
#     #       timeout_in_seconds             = 30
#     #       evaluation_interval_in_seconds = 30
#     #       unhealthy_treshold_count       = 3
#     #       fqdn                           = "ffsterraform.azurewebsites.net"
#     #       path                           = "/"
#     #       status_codes                   = ["200-599"]
#     #     }
#     #   }
#     # },
#     ## pedro.nmbrs.nl
#     # {
#     #   routing_rule = {
#     #     priority = 2
#     #   }
#     #   listener = {
#     #     fqdn             = "pedro.nmbrs.nl"
#     #     protocol         = "https"
#     #     certificate_name = "nmbrs-nl"
#     #   }
#     #   backend = {
#     #     fqdns                         = ["pmlterraform.azurewebsites.net"]
#     #     port                          = 443
#     #     protocol                      = "https"
#     #     cookie_based_affinity_enabled = false
#     #     request_timeout_in_seconds    = 30
#     #     health_probe = {
#     #       fqdn                           = "pedro.nmbrs.nl"
#     #       timeout_in_seconds             = 30
#     #       evaluation_interval_in_seconds = 30
#     #       unhealthy_treshold_count       = 3
#     #       path                           = "/"
#     #       status_codes                   = ["200-599"]
#     #     }
#     #   }
#     # },
#     ## merou.nmbrs.nl
#     # {
#     #   routing_rule = {
#     #     priority = 3
#     #   }
#     #   listener = {
#     #     fqdn             = "merou.nmbrs.nl"
#     #     protocol         = "https"
#     #     certificate_name = "nmbrs-nl"
#     #   }
#     #   backend = {
#     #     fqdns                         = ["pmlterraform.azurewebsites.net"]
#     #     port                          = 443
#     #     protocol                      = "https"
#     #     cookie_based_affinity_enabled = false
#     #     request_timeout_in_seconds    = 30
#     #     health_probe = {
#     #       fqdn                           = "merou.nmbrs.nl"
#     #       timeout_in_seconds             = 30
#     #       evaluation_interval_in_seconds = 30
#     #       unhealthy_treshold_count       = 3
#     #       path                           = "/"
#     #       status_codes                   = ["200"]
#     #     }
#     #   }
#     # },
#     # {
#     #   routing_rule = {
#     #     priority = 101
#     #   }
#     #   listener = {
#     #     fqdn             = "*.nmbrs.nl"
#     #     protocol         = "http"
#     #   }
#     #   backend = {
#     #     fqdns                         = ["pmlterraform.azurewebsites.net"]
#     #     port                          = 443
#     #     protocol                      = "https"
#     #     cookie_based_affinity_enabled = false
#     #     request_timeout_in_seconds    = 30
#     #     health_probe = {
#     #       fqdn                           = "pedro.nmbrs.nl"
#     #       timeout_in_seconds             = 30
#     #       evaluation_interval_in_seconds = 30
#     #       unhealthy_treshold_count       = 3
#     #       path                           = "/"
#     #       status_codes                   = ["200-599"]
#     #     }
#     #   }
#     # },

#     ## nmbrs-test.nl entries
#     # {
#     #   routing_rule = {
#     #     priority = 3
#     #   }
#     #   listener = {
#     #     fqdn             = "web.nmbrs-test.nl"
#     #     protocol         = "https"
#     #     certificate_name = "nmbrs-test-nl"
#     #   }
#     #   backend = {
#     #     fqdns                         = ["as-web-n1-test-nl.azurewebsites.net", "as-monolith-web-n2-nl-test.azurewebsites.net"]
#     #     port                          = 443
#     #     protocol                      = "https"
#     #     cookie_based_affinity_enabled = true
#     #     request_timeout_in_seconds    = 230
#     #     health_probe = {
#     #       timeout_in_seconds             = 30
#     #       evaluation_interval_in_seconds = 30
#     #       unhealthy_treshold_count       = 3
#     #       path                           = "/"
#     #       status_codes                   = ["200-599"]
#     #     }
#     #   }
#     # },
#     # {
#     #   routing_rule = {
#     #     priority = 3
#     #   }
#     #   listener = {
#     #     fqdn             = "web.nmbrs-test.nl"
#     #     protocol         = "https"
#     #     certificate_name = "nmbrs-test-nl"
#     #   }
#     #   backend = {
#     #     fqdns                         = ["as-web-n1-test-nl.azurewebsites.net", "as-monolith-web-n2-nl-test.azurewebsites.net"]
#     #     port                          = 443
#     #     protocol                      = "https"
#     #     cookie_based_affinity_enabled = true
#     #     request_timeout_in_seconds    = 230
#     #     health_probe = {
#     #       timeout_in_seconds             = 30
#     #       evaluation_interval_in_seconds = 30
#     #       unhealthy_treshold_count       = 3
#     #       path                           = "/"
#     #       status_codes                   = ["200-599"]
#     #     }
#     #   }
#     # },
#   ]

#   redirect_url_settings = [
#     #### nmbrs.se entries
#     # https://*.nmbrs.se
#     {
#       routing_rule = {
#         priority = 6099
#       }
#       listener = {
#         fqdn             = "*.nmbrs.se"
#         protocol         = "https"
#         certificate_name = "nmbrs-se"
#       }
#       target = {
#         url                  = "https://www.nmbrs.com/sv"
#         include_path         = true
#         include_query_string = true
#       }
#     },
#     # http://*.nmbrs.se
#     {
#       routing_rule = {
#         priority = 6098
#       }
#       listener = {
#         fqdn     = "*.nmbrs.se"
#         protocol = "http"
#       }
#       target = {
#         url                  = "https://www.nmbrs.com/sv"
#         include_path         = true
#         include_query_string = true
#       }
#     },

#     # https://nmbrs.se
#     {
#       routing_rule = {
#         priority = 6097
#       }
#       listener = {
#         fqdn             = "nmbrs.se"
#         protocol         = "https"
#         certificate_name = "nmbrs-se"
#       }
#       target = {
#         url                  = "https://www.nmbrs.com/sv"
#         include_path         = true
#         include_query_string = true
#       }
#     },

#     # http://nmbrs.se
#     {
#       routing_rule = {
#         priority = 6096
#       }
#       listener = {
#         fqdn     = "nmbrs.se"
#         protocol = "http"
#       }
#       target = {
#         url                  = "https://www.nmbrs.com/sv"
#         include_path         = true
#         include_query_string = true
#       }
#     },

#     #https://www.nmbrs.se
#     {
#       routing_rule = {
#         priority = 6095
#       }
#       listener = {
#         fqdn             = "www.nmbrs.se"
#         protocol         = "https" #443
#         certificate_name = "nmbrs-se"
#       }
#       target = {
#         url                  = "https://www.nmbrs.com/sv"
#         include_path         = true
#         include_query_string = true
#       }
#     },

#     # http://www.nmbrs.se
#     {
#       routing_rule = {
#         priority = 6094
#       }
#       listener = {
#         fqdn     = "www.nmbrs.se"
#         protocol = "http" #80
#       }
#       target = {
#         url                  = "https://www.nmbrs.com/sv"
#         include_path         = true
#         include_query_string = true
#       }
#     },

#     # https://filipe.nmbrs.se - no query or path
#     # {
#     #   routing_rule = {
#     #     priority = 6090
#     #   }
#     #   listener = {
#     #     fqdn             = "filipe.nmbrs.se"
#     #     protocol         = "https"
#     #     certificate_name = "nmbrs-se"
#     #   }
#     #   target = {
#     #     url                  = "https://nmbrsdev.jira.com/wiki/display/NMBRSBOOK/Nmbrs+Book"
#     #     include_path         = false
#     #     include_query_string = false
#     #   }
#     # },

#     # http://filipe.nmbrs.se - no query or path
#     # {
#     #   routing_rule = {
#     #     priority = 6089
#     #   }
#     #   listener = {
#     #     fqdn     = "filipe.nmbrs.se"
#     #     protocol = "http"
#     #   }
#     #   target = {
#     #     url                  = "https://nmbrsdev.jira.com/wiki/display/NMBRSBOOK/Nmbrs+Book"
#     #     include_path         = false
#     #     include_query_string = false
#     #   }
#     # }
#   ]

#   redirect_listener_settings = [
#     # {
#     #   routing_rule = {
#     #     priority = 1000
#     #   }
#     #   listener = {
#     #     fqdn     = "*.nmbrs.nl"
#     #     protocol = "http" # may disappear
#     #   }
#     #   target = {
#     #     listener_name        = "listener-https-wildcard-nmbrs-nl"
#     #     include_path         = true
#     #     include_query_string = true
#     #   }
#     # }
#   ]



#   #################







#   depends_on = [module.managed_identity, module.resource_group_vnet_001]
# }


# Storage Account
module "storage_account_no_caf" {
  source              = "./azure/storage_account"
  workload            = "defenderdemo"
  environment         = module.environment.name
  location            = module.location.name
  resource_group_name = module.resource_group_vnet_001.name
  account_kind        = "StorageV2"
  account_tier        = "Premium"
  replication_type    = "LRS"
}

module "storage_account_defender" {
  source              = "./azure/storage_account"
  workload            = "uploaddemo"
  environment         = module.environment.name
  location            = module.location.name
  resource_group_name = module.resource_group_vnet_001.name
  account_kind        = "StorageV2"
  account_tier        = "Premium"
  replication_type    = "LRS"
}

module "storage_account_defende_blob" {
  source              = "./azure/storage_account"
  workload            = "uploadblob"
  environment         = module.environment.name
  location            = module.location.name
  resource_group_name = module.resource_group_vnet_001.name
  account_kind        = "BlobStorage"
  account_tier        = "Standard"
  replication_type    = "GRS"
}

resource "azurerm_eventgrid_topic" "example" {
  name                = "filipe-eventgrid-topic"
  location            = module.location.name
  resource_group_name = module.resource_group_vnet_001.name

  lifecycle {
    ignore_changes = [tags]
  }
}

#############################
# Container App Environment
#############################


#Log analytics workspace
module "log_analytics_workspace" {
  source              = "./azure/log_analytics_workspace"
  workload                = "myworkload"
  resource_group_name = module.resource_group_vnet_001.name
  environment         = module.environment.name
  location            = module.location.name
  sku_name            = "PerGB2018"
  retention_in_days   = 90
}

# module "container_app_environment" {
#   source              = "./azure/container_app_environment"
#   workload            = "myworkload"
#   resource_group_name = module.resource_group_vnet_001.name
#   environment         = module.environment.name
#   location            = module.location.name
#   network_settings = {
#     subnet_name              = "snet-caedemo"
#     vnet_name                = module.vnet_001.name
#     vnet_resource_group_name = module.resource_group_vnet_001.name
#   }
#   log_analytics_worspace_settings = {
#     resource_group_name = module.resource_group_vnet_001.name
#     name                = "wsp-myworkload-dev"
#   }
# }

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



# module "virtual_network2" {
#   source              = "./azure/virtual_network"
#   resource_group_name = module.resource_group.name
#   name                = "vnet-dev-westeu-901"
#   address_spaces      = ["10.91.0.0/16"]
#   environment         = "dev"
#   subnets = [
#     {
#       name                                          = "snet-dev-vms-001"
#       address_prefixes                              = ["10.91.10.0/24"]
#       private_link_service_network_policies_enabled = false
#       private_endpoint_network_policies_enabled     = false
#       service_endpoints                             = []
#       delegations                                   = []
#     },
#   ]
# }

##############################################################
# App Service
##############################################################

# Resource Group - App Service
# module "resource_group_appservice_001" {
#   source      = "./azure/resource_group"
#   workload    = "tf-filipe-app"
#   location    = module.location.name
#   environment = module.environment.name
#   tags = {
#     environment = module.environment.name
#     managed_by  = "terraform"
#     product     = var.product
#     category    = var.category
#     owner       = var.owner
#     country     = var.country
#     status      = var.status
#   }
# }



# App Service
# module "app_service_plan" {
#   source              = "./azure/app_service"
#   node_number         = 1
#   country             = "nl"
#   service_plan_name   = "tffilipe"
#   resource_group_name = module.resource_group_appservice_001.name
#   environment         = module.environment.name
#   location            = module.location.name
#   sku_name            = "P2v3"
#   stack               = "dotnet"
#   dotnet_version      = "v4.0"

#   network_settings = {
#     vnet_resource_group_name = module.resource_group_vnet_001.name
#     vnet_name                = module.vnet_001.name
#     subnet_name              = "snet-appservicesmonolith-001"
#   }

#   app_service_names = ["web", "worker", "over"]
# }

# Log analytics workspace
# module "log_analytics_workspace_app_service" {
#   source              = "./azure/log_analytics_workspace"
#   workload            = "myworkspace"
#   resource_group_name = module.resource_group_appservice_001.name
#   environment         = module.environment.name
#   location            = module.location.name
#   sku_name            = "PerGB2018"
#   retention_in_days   = 90
# }

# App Insights
# module "app_insights" {
#   source                        = "./azure/application_insights"
#   workspace_name                = module.log_analytics_workspace_app_service.name
#   workspace_resource_group_name = module.resource_group_appservice_001.name
#   workload                      = "myapp-n1-nl"
#   application_type              = "web"
#   resource_group_name           = module.resource_group_appservice_001.name
#   environment                   = module.environment.name
#   location                      = module.location.name
#   sku_name                      = "PerGB2018"
#   retention_in_days             = 90
# }


# ## cosmos_db
# module "cosmos_mongo_db" {
#   source              = "./azure/cosmos_db"
#   resource_group_name = module.resource_group_appservice_001.name
#   name                = "cosmon-filipe-dev"
#   environment         = module.environment.name
#   location            = module.location.name
#   kind                = "MongoDB"
#   mongo_db_version    = "4.2"

# }

# module "peering_vnet-dev-westeu-900_to_vnet-dev-westeu-901" {
#   source = "./azure/virtual_network_peering"
#   vnet_source = {
#     name                         = module.virtual_network.name
#     resource_group_name          = module.resource_group.name
#     allow_forwarded_traffic      = true
#     allow_gateway_transit        = true
#     allow_virtual_network_access = true
#     use_remote_gateways          = false
#   }
#   vnet_destination = {
#     name                         = module.virtual_network2.name
#     resource_group_name          = module.resource_group.name
#     allow_forwarded_traffic      = true
#     allow_gateway_transit        = true
#     allow_virtual_network_access = true
#     use_remote_gateways          = false
#   }
# }

# module "peering_vnet-dev-westeu-900_to_VNet-NetworkHubTest" {
#   source = "./azure/virtual_network_peering"
#   vnet_source = {
#     name                         = module.virtual_network.name
#     resource_group_name          = module.resource_group.name
#     allow_forwarded_traffic      = true
#     allow_gateway_transit        = true
#     allow_virtual_network_access = true
#     use_remote_gateways          = true
#   }
#   vnet_destination = {
#     name                         = "VNet-NetworkHubTest"
#     resource_group_name          = "RG-WE-Networking"
#     allow_forwarded_traffic      = true
#     allow_gateway_transit        = true
#     allow_virtual_network_access = true
#     use_remote_gateways          = false
#   }
# }

## Key Vault
# module "key_vault" {
#   source              = "./azure/key_vault"
#   name                = "prkv"
#   resource_group_name = module.resource_group_appservice_001.name
#   external_usage      = true
#   environment         = "dev"
#   location            = "westeurope"
#   policies = [
#     {
#       name      = "sg-mysquad"
#       type      = "writers"
#       object_id = "ee3dbd9f-b299-4b72-a3f9-ffdca17098b0"
#     },
#   ]
# }

# ## Storage Account
# module "storage_account" {
#   source              = "./azure/storage_account"
#   name                = "sauniquename123"
#   environment         = module.environment.name
#   location            = module.location.name
#   resource_group_name = module.resource_group_appservice_001.name
#   account_kind        = "StorageV2"
#   account_tier        = "Premium"
#   replication_type    = "LRS"
# }

# ## DNS Zone
# module "dns_zone" {
#   source              = "./azure/dns_zone"
#   name                = "contoso.com.dev"
#   resource_group_name = module.resource_group.name
# }

# ## DNS Records
# module "dns_records" {
#   source        = "./azure/dns_records"
#   dns_zone_name = module.dns_zone.name
#   dns_zone_rg   = module.resource_group.name
#   a = [
#     {
#       name    = "web"
#       records = ["192.168.1.1"]
#       ttl     = 300
#     },
#     {
#       name    = "worker"
#       records = ["192.168.1.2", "192.168.1.3"]
#       ttl     = 300
#     }
#   ]

#   cname = [
#     {
#       name   = "api"
#       record = "api.azurewebsites.net"
#       ttl    = 300
#     }
#   ]

#   txt = [
#     {
#       name    = "_acme-challenge"
#       records = ["__2asdnkaASAFc-Xx8ASFASGFmka-EwvGO5asdqwWfasfdR64No"]
#       ttl     = 300
#     }
#   ]
# }


# module "virtual_machine_linux" {
#   source = "./azure/virtual_machine"

#   vm_name             = var.vm_linux_name
#   environment         = module.environment.name
#   resource_group_name = module.resource_group.name
#   vm_size             = "Standard_DS2_v2"
#   os_type             = "linux"
#   os_image = {
#     publisher = "Canonical"
#     offer     = "0001-com-ubuntu-server-jammy"
#     sku       = "22_04-lts-gen2"
#     version   = "latest"
#   }

#   os_disk = {
#     name                 = "dsk-${var.vm_linux_name}-os-001"
#     caching              = "ReadWrite"
#     storage_account_type = "StandardSSD_LRS"
#   }

#   data_disks = [{
#     caching              = "None"
#     disk_size_gb         = 10
#     name                 = "dsk-${var.vm_linux_name}-data-001"
#     storage_account_type = "StandardSSD_LRS"
#   }]

#   network_interfaces = [
#     {
#       name                     = "nic-${var.vm_linux_name}-001",
#       vnet_resource_group_name = module.resource_group.name
#       vnet_name                = "vnet-dev-westeu-900"
#       subnet_name              = "lemons"
#     },
#     {
#       name                     = "nic-${var.vm_linux_name}-002",
#       vnet_resource_group_name = module.resource_group.name
#       vnet_name                = "vnet-dev-westeu-900"
#       subnet_name              = "lemons"
#     }
#   ]
# }

# module "virtual_machine_windows" {
#   source = "./azure/virtual_machine"

#   vm_name             = var.vm_windows_name
#   environment         = module.environment.name
#   resource_group_name = module.resource_group.name
#   vm_size             = "Standard_DS2_v2"
#   os_type             = "windows"
#   os_image = {
#     publisher = "MicrosoftWindowsServer"
#     offer     = "WindowsServer"
#     sku       = "2016-Datacenter"
#     version   = "latest"
#   }

#   network_interfaces = [
#     {
#       name                     = "nic-${var.vm_windows_name}-001",
#       vnet_resource_group_name = module.resource_group.name
#       vnet_name                = "vnet-dev-westeu-900"
#       subnet_name              = "lemons"
#     },
#     {
#       name                     = "nic-${var.vm_windows_name}-002",
#       vnet_resource_group_name = module.resource_group.name
#       vnet_name                = "vnet-dev-westeu-900"
#       subnet_name              = "lemons"
#     }
#   ]

#   os_disk = {
#     name                 = "dsk-${var.vm_windows_name}-os-001"
#     caching              = "ReadWrite"
#     storage_account_type = "StandardSSD_LRS"
#   }

#   data_disks = [
#     {
#       caching              = "None"
#       disk_size_gb         = 10
#       name                 = "dsk-${var.vm_windows_name}-data-001"
#       storage_account_type = "StandardSSD_LRS"
#     },
#     {
#       caching              = "None"
#       disk_size_gb         = 100
#       name                 = "dsk-${var.vm_windows_name}-data-002"
#       storage_account_type = "StandardSSD_LRS"
#     }
#   ]
# }

# Private DNS Zone
# module "private_dns_zone" {
#   source              = "./azure/private_dns_zone"
#   name                = "filipe.test.localhost.com"
#   resource_group_name = module.resource_group.name

#   vnet_links = [
#     {
#       vnet_name            = module.virtual_network.name
#       vnet_resource_group  = module.resource_group.name
#       registration_enabled = true
#     }
#   ]
# }

# ## DNS Zone
# module "dns_zone" {
#   source      = "./azure/dns_zone"
#   name        = "a.com.br.a.c"
#   resource_group_name = module.resource_group.name
# }


# NAT Gateway 
# Resource Group
# module "resource_group_ng" {
#   source      = "./azure/resource_group"
#   name        = "pr_project_ngw"
#   location    = module.location.name
#   environment = module.environment.name
#   tags = {
#     environment = module.environment.name
#     managed_by  = "terraform"
#     product     = var.product
#     category    = var.category
#     owner       = var.owner
#     country     = var.country
#     status      = var.status
#   }
# }

# # NAT Gateway module
# module "nat_gateway" {
#   source                   = "./azure/nat_gateway"
#   workload                 = "vm-public-ffs"
#   instance_count           = 1
#   vnet_name                = module.vnet_001.name
#   vnet_resource_group_name = module.resource_group_vnet_001.name
#   subnets                  = ["snet-natgateway-001"]
#   resource_group_name      = module.resource_group_vnet_001.name
#   environment              = module.environment.name
#   location                 = module.location.name

# }

# #private DNS resolver
# module "private_dns_resolver" {
#   source = "./azure/private_dns_resolver"

#   workload                 = "ffs"
#   instance_count           = 1
#   resource_group_name      = module.resource_group_vnet_001.name
#   location                 = module.location.name
#   environment              = module.environment.name
#   vnet_name                = module.vnet_001.name
#   vnet_resource_group_name = module.resource_group_vnet_001.name
#   inbound_endpoints        = ["snet-inboundprivatedns-dev-westeurope-001"]
#   outbound_endpoints       = ["snet-outboundprivatedns-dev-westeurope-001"]

#   depends_on = [module.vnet_001]
# }

###########################################
## Resource Group - Redis
# module "resource_group_redis_001" {
#   source      = "./azure/resource_group"
#   name        = "tf-filipe-redis"
#   location    = module.location.name
#   environment = module.environment.name
#   tags = {
#     environment = module.environment.name
#     product     = var.product
#     category    = var.category
#     owner       = var.owner
#     country     = var.country
#     status      = var.status
#   }
# }

# # Redis Premium Cluster
# module "redis_cache_premium" {
#   source              = "./azure/redis_cache"
#   name                = "ffs-premium"
#   resource_group_name = module.resource_group_redis_001.name
#   environment         = module.environment.name
#   location            = module.location.name
#   sku_name            = "Premium"
#   cache_size_in_gb    = 6
#   shard_count         = 0
# }

# # Redis Cluster
# module "redis_cache_premium_no_cluster" {
#   source              = "./azure/redis_cache"
#   name                = "no-cluster-premium"
#   resource_group_name = module.resource_group_redis_001.name
#   environment         = module.environment.name
#   location            = module.location.name
#   sku_name            = "Premium"
#   cache_size_in_gb    = 6
#   shard_count         = 1
# }

# # Redis Cluster
# module "redis_cache_standard" {
#   source              = "./azure/redis_cache"
#   name                = "no-cluster-standard"
#   resource_group_name = module.resource_group_redis_001.name
#   environment         = module.environment.name
#   location            = module.location.name
#   sku_name            = "Standard"
#   cache_size_in_gb    = 0.25
#   shard_count         = 0
# }


# # Redis Cluster
# module "redis_cache_basic" {
#   source              = "./azure/redis_cache"
#   name                = "no-cluster-basic"
#   resource_group_name = module.resource_group_redis_001.name
#   environment         = module.environment.name
#   location            = module.location.name
#   sku_name            = "Basic"
#   cache_size_in_gb    = 2.5
#   shard_count         = 0
# }

# module "redis_cache_premium_cluster" {
#   source               = "./azure/redis_cache"
#   name                 = "cluster-premium"
#   resource_group_name  = module.resource_group.name
#   environment          = module.environment.name
#   cache_size_gb        = 6
#   shard_count          = 2  
# }
############################################

## On hold: issues with azure
## https://github.com/hashicorp/terraform-provider-azurerm/issues/21967


# ## Resource Group - App Service
# module "resource_group_sb_001" {
#   source      = "./azure/resource_group"
#   workload    = "tf-filipe-sb"
#   location    = module.location.name
#   environment = module.environment.name
#   tags = {
#     environment = module.environment.name
#     product     = var.product
#     category    = var.category
#     owner       = var.owner
#     country     = var.country
#     status      = var.status
#     managed_by  = "terraform"
#   }
# }

# module "service_bus_001" {
#   source              = "./azure/service_bus"
#   resource_group_name = module.resource_group_sb_001.name
#   workload            = "basictf"
#   environment         = module.environment.name
#   location            = module.location.name
#   sku_name            = "Basic"
#   capacity            = 0
#   zone_redundant      = false
# }

# module "service_bus_002" {
#   source              = "./azure/service_bus"
#   resource_group_name = module.resource_group_sb_001.name
#   workload            = "standardtf"
#   environment         = module.environment.name
#   location            = module.location.name
#   sku_name            = "Standard"
#   capacity            = 0
#   zone_redundant      = false
# }

# module "service_bus_003" {
#   source              = "./azure/service_bus"
#   resource_group_name = module.resource_group_sb_001.name
#   workload            = "premiumnoredtf"
#   environment         = module.environment.name
#   location            = module.location.name
#   sku_name            = "Premium"
#   capacity            = 2
#   zone_redundant      = true
# }

# module "service_bus_004" {
#   source              = "./azure/service_bus"
#   resource_group_name = module.resource_group_sb_001.name
#   workload            = "premiumredundancytf"
#   environment         = module.environment.name
#   location            = module.location.name
#   sku_name            = "Premium"
#   capacity            = 4
#   zone_redundant      = false
# }



# module "event_grid_domain" {
#   source                        = "./azure/event_grid_domain"
#   workload                      = "ffs"
#   location                      = module.resource_group_vnet_001.location
#   resource_group_name           = module.resource_group_vnet_001.name
#   environment                   = module.environment.name
#   public_network_access_enabled = false
# }

# module "managed_identity" {
#   source              = "./azure/managed_identity"
#   workload            = "tf-pr"
#   resource_group_name = module.resource_group_vnet_001.name
#   environment         = module.environment.name
#   location            = module.location.name
# } 

# module "vpn_gateway" {
#   source                   = "./azure/vpn_gateway"
#   workload                     = "testvpn"
#   instance_count = 1
#   environment              = module.environment.name
#   location                 = module.location.name
#   resource_group_name      = module.resource_group_vnet_001.name
#   vnet_resource_group_name = module.resource_group_vnet_001.name
#   vnet_name                = "vnet-tfsample-dev-westeurope-900"
#   address_spaces           = ["10.156.80.0/24"]

#   depends_on = [ module.vnet_001 ]
# }
