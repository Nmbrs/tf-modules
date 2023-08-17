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
  name        = "tf-filipe-vnet-001"
  location    = module.location.name
  environment = module.environment.name
  product     = var.product
  category    = var.category
  owner       = var.owner
  country     = var.country
  status      = var.status
}


## Virtual Network
module "vnet_001" {
  source              = "./azure/virtual_network"
  resource_group_name = module.resource_group_vnet_001.name
  name                = "vnet-dev-westeu-900"
  address_spaces      = ["10.90.0.0/16"]
  environment         = module.environment.name
  subnets = [
    {
      name                                          = "snet-appservicesmonolith-001"
      address_prefixes                              = ["10.90.10.0/24"]
      private_link_service_network_policies_enabled = false
      private_endpoint_network_policies_enabled     = false
      service_endpoints                             = []
      delegations                                   = ["Microsoft.Web/serverFarms"]
    },
    #     {
    #   name                                          = "snet-appservicesmonolith-002"
    #   address_prefixes                              = ["10.90.10.0/24"]
    #   private_link_service_network_policies_enabled = false
    #   private_endpoint_network_policies_enabled     = false
    #   service_endpoints                             = []
    #   delegations                                   = ["Microsoft.Web/serverFarms"]
    # },
    # {
    #   name                                          = "apples"
    #   address_prefixes                              = ["10.90.11.0/24"]
    #   private_link_service_network_policies_enabled = false
    #   private_endpoint_network_policies_enabled     = false
    #   service_endpoints                             = ["Microsoft.EventHub"]
    #   delegations                                   = ["Microsoft.ContainerInstance/containerGroups"]
    # },
    # {
    #   name                                          = "lemons"
    #   address_prefixes                              = ["10.90.12.0/24"]
    #   private_link_service_network_policies_enabled = false
    #   private_endpoint_network_policies_enabled     = false
    #   service_endpoints                             = []
    #   delegations                                   = []
    # },
    # {
    #   name                                          = "snet-outboundprivatedns-001"
    #   address_prefixes                              = ["10.90.13.0/24"]
    #   private_link_service_network_policies_enabled = true
    #   private_endpoint_network_policies_enabled     = false
    #   service_endpoints                             = []
    #   delegations                                   = ["Microsoft.Network/dnsResolvers"]
    # },
    # {
    #   name                                          = "snet-inboundprivatedns-001"
    #   address_prefixes                              = ["10.90.14.0/24"]
    #   private_link_service_network_policies_enabled = true
    #   private_endpoint_network_policies_enabled     = false
    #   service_endpoints                             = []
    #   delegations                                   = ["Microsoft.Network/dnsResolvers"]
    # },
  ]
}

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


## Resource Group - App Service
module "resource_group_appservice_001" {
  source      = "./azure/resource_group"
  name        = "tf-filipe-app"
  location    = module.location.name
  environment = module.environment.name
  product     = var.product
  category    = var.category
  owner       = var.owner
  country     = var.country
  status      = var.status
}

# App Service
module "app_service_plan" {
  source              = "./azure/app_service"
  service_plan_name   = "monolith"
  resource_group_name = module.resource_group_appservice_001.name
  environment         = module.environment.name
  sku_name            = "P2v3"
  stack               = "dotnet"
  dotnet_version      = "v4.0"

  network_settings = {
    vnet_resource_group_name = module.resource_group_vnet_001.name
    vnet_name                = module.vnet_001.name
    subnet_name              = "snet-appservicesmonolith-001"
  }

  app_service_names = ["web", "worker", "over"]
}

# output "app_service" {
#   value = {
#     app_insights_instrumentation_key = module.app_service_plan.app_insights_instrumentation_key
#     app_insights_id = module.app_service_plan.app_insights_id
#     service_plan_id = module.app_service_plan.service_plan_id
#     service_plan_os_type = module.app_service_plan.service_plan_os_type
#     service_plan_sku_name = module.app_service_plan.service_plan_sku_name
#     app_services = module.app_service_plan.app_services
#   }
#   sensitive = true
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

# ## Key Vault
# module "keyvault" {
#   source              = "./azure/key_vault"
#   name                = "prkv"
#   resource_group_name = module.resource_group.name
#   external_usage      = true
#   environment         = "dev"
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
#   resource_group_name = module.resource_group.name
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


## NAT Gateway 
## Resource Group
# module "resource_group_ngw" {
#   source      = "./azure/resource_group"
#   name        = "pr_project_ngw"
#   location    = module.location.name
#   environment = module.environment.name
# }

## NAT Gateway module
# module "nat_gateway" {
#   source               = "./azure/nat_gateway"
#   name                 = "vm-public-ffs"
#   vnet_name            = module.virtual_network.name
#   vnet_resource_group  = module.resource_group.name
#   subnets              = ["lemons"]
#   natgw_resource_group = module.resource_group_ngw.name
#   environment          = module.environment.name
# }

## NAT Gateway 
## Resource Group
# module "resource_group_dnsres" {
#   source      = "./azure/resource_group"
#   name        = "pr_project_dnsres"
#   location    = module.location.name
#   environment = module.environment.name
# }

# private DNS resolver
# module "private_dns_resolver" {
#   source = "./azure/private_dns_resolver"

#   name                     = "ffs-001"
#   resource_group_name      = module.resource_group.name
#   location                 = module.location.name
#   environment              = module.environment.name
#   vnet_name                = module.virtual_network.name
#   vnet_resource_group_name = module.resource_group.name
#   inbound_endpoints        = ["snet-inboundprivatedns-001"]
#   outbound_endpoints       = ["snet-outboundprivatedns-001"]
# }

# # Redis Cluster
# module "redis_cache_premium" {
#   source               = "./azure/redis_cache"
#   name                 = "ffs-premium"
#   resource_group_name  = module.resource_group.name
#   environment          = module.environment.name
#   cache_size_gb        = 6
# }

# # Redis Cluster
# module "redis_cache_premium_no_cluster" {
#   source               = "./azure/redis_cache"
#   name                 = "no-cluster-premium"
#   resource_group_name  = module.resource_group.name
#   environment          = module.environment.name
#   cache_size_gb        = 6
# }

# module "redis_cache_premium_cluster" {
#   source               = "./azure/redis_cache"
#   name                 = "cluster-premium"
#   resource_group_name  = module.resource_group.name
#   environment          = module.environment.name
#   cache_size_gb        = 6
#   shard_count          = 2  
# }

## On hold: issues with azure
## https://github.com/hashicorp/terraform-provider-azurerm/issues/21967
# # azurerm_redis_cache.bs_cache" "basic" {
#   capacity            = 1
#   enable_non_ssl_port = false
#   family              = "C"
#   location            = "westeurope"
#   minimum_tls_version = "1.2"
#   name                = "redis-nmbrsservices-test"

#   public_network_access_enabled = true
#   redis_version                 = 6
#   resource_group_name           = "rg-cache-test"
#   shard_count                   = 0
#   sku_name                      = "Standard"

#   tenant_settings = {}
#   zones           = []

#   redis_configuration {
#     aof_backup_enabled              = false
#     enable_authentication           = true    
#     # rdb_backup_enabled    = null
#     maxmemory_policy      = "volatile-lru"
#     }
#   lifecycle {
#     ignore_changes = [tags]
#   }
# }asic:
# resource "azurerm_redi

# module "storage_account" {
#   source              = "./azure/storage_account"
#   resource_group_name = module.resource_group.name
#   environment         = module.environment.name
#   name                = "sauniquename123"

#   account_kind     = "StorageV2"
#   account_tier     = "Standard"
#   replication_type = "LRS"
# }
