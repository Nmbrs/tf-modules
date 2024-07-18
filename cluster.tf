## Resource Group
# module "resource_group_vnet_vpn" {
#   source      = "./azure/resource_group"
#   name        = "tf-filipe-vnet-vpn-002"
#   location    = module.location.name
#   environment = module.environment.name
#   product     = var.product
#   category    = var.category
#   owner       = var.owner
#   country     = var.country
#   status      = var.status
# }

# module "vnet_vpn" {
#   source              = "./azure/virtual_network"
#   resource_group_name = module.resource_group_vnet_001.name
#   name                = "vnet-dev-westeu-1000"
#   address_spaces      = ["10.111.0.0/16"]
#   environment         = module.environment.name
#   location            = module.location.name
#   subnets = [
#     {
#       name                                          = "snet-vpn-gateway-001"
#       address_prefixes                              = ["10.111.1.0/24"]
#       private_link_service_network_policies_enabled = false
#       private_endpoint_network_policies_enabled     = false
#       service_endpoints                             = []
#       delegations                                   = []
#     }
#   ]
# }


# module "resource_group_cluster" {
#   source      = "./azure/resource_group"
#   name        = "tf-filipe-vnet-cluster-001"
#   location    = module.location.name
#   environment = module.environment.name
# }


# module "vnet_cluster" {
#   source              = "./azure/virtual_network"
#   resource_group_name = module.resource_group_cluster.name
#   name                = "vnet-dev-westeu-1001"
#   address_spaces      = ["10.112.0.0/16"]
#   environment         = module.environment.name
#   location            = module.location.name
#   subnets = [
#     {
#       name                                          = "snet-virtualmachines-001"
#       address_prefixes                              = ["10.112.1.0/24"]
#       private_link_service_network_policies_enabled = false
#       private_endpoint_network_policies_enabled     = false
#       service_endpoints                             = []
#       delegations                                   = []
#     },
#     {
#       name                                          = "snet-inboundprivatedns-001"
#       address_prefixes                              = ["10.112.2.0/24"]
#       private_link_service_network_policies_enabled = true
#       private_endpoint_network_policies_enabled     = false
#       service_endpoints                             = []
#       delegations                                   = ["Microsoft.Network/dnsResolvers"]
#     },
#     {
#       name                                          = "snet-outboundprivatedns-001"
#       address_prefixes                              = ["10.112.3.0/24"]
#       private_link_service_network_policies_enabled = true
#       private_endpoint_network_policies_enabled     = false
#       service_endpoints                             = []
#       delegations                                   = ["Microsoft.Network/dnsResolvers"]
#     },
#     {
#       name                                          = "snet-natgatweay-001"
#       address_prefixes                              = ["10.112.4.0/24"]
#       private_link_service_network_policies_enabled = false
#       private_endpoint_network_policies_enabled     = false
#       service_endpoints                             = []
#       delegations                                   = []
#     },
#   ]
# }

# # vnet peering
# module "peering_vnet-dev-westeu-1001_to_vnet-vpn" {
#   source = "./azure/virtual_network_peering"
#   vnet_source = {
#     name                         = module.vnet_cluster.name
#     resource_group_name          = module.resource_group_cluster.name
#     allow_forwarded_traffic      = true
#     allow_gateway_transit        = true
#     allow_virtual_network_access = true
#     use_remote_gateways          = true
#   }
#   vnet_destination = {
#     name                         = module.vnet_vpn.name
#     resource_group_name          = module.resource_group_vnet_001.name
#     allow_forwarded_traffic      = true
#     allow_gateway_transit        = true
#     allow_virtual_network_access = true
#     use_remote_gateways          = false
#   }
# }

# NAT Gateway module
# module "nat_gateway" {
#   source                   = "./azure/nat_gateway"
#   name                     = "cluster"
#   vnet_name                = module.vnet_cluster.name
#   vnet_resource_group_name = module.resource_group_cluster.name
#   subnets                  = ["snet-natgatweay-001"]
#   resource_group_name      = module.resource_group_cluster.name
#   environment              = module.environment.name
#   location                 = module.location.name
# }

# # private DNS resolver
# module "private_dns_resolver" {
#   source = "./azure/private_dns_resolver"

#   name                     = "cluster"
#   resource_group_name      = module.resource_group_cluster.name
#   location                 = module.location.name
#   environment              = module.environment.name
#   vnet_name                = module.vnet_cluster.name
#   vnet_resource_group_name = module.resource_group_cluster.name
#   inbound_endpoints        = ["snet-inboundprivatedns-001"]
#   outbound_endpoints       = ["snet-outboundprivatedns-001"]
# }

# # Private DNS Zone
# module "private_dns_zone" {
#   source              = "./azure/private_dns_zone"
#   name                = "filipe.test.localhost.com"
#   resource_group_name = module.resource_group_cluster.name

#   vnet_links = [
#     {
#       vnet_name            = module.vnet_cluster.name
#       vnet_resource_group  = module.resource_group_cluster.name
#       registration_enabled = true
#     }
#   ]
# }



## Virtual Machines
##
##

# module "resource_group_vms" {
#   source      = "./azure/resource_group"
#   name        = "tf-filipe-vms-cluster-001"
#   location    = module.location.name
#   environment = module.environment.name
# }

# variable "vm_master_name" {
#   default = "vmmaster"
# }

# module "vm_windows_master" {
#   source = "./azure/virtual_machine"

#   vm_name             = var.vm_master_name
#   environment         = module.environment.name
#   location            = module.location.name
#   resource_group_name = module.resource_group_vms.name
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
#       name                     = "nic-${var.vm_master_name}-001",
#       vnet_resource_group_name = module.resource_group_cluster.name
#       vnet_name                = "vnet-dev-westeu-1001"
#       subnet_name              = "snet-virtualmachines-001"
#     },
#   ]

#   os_disk = {
#     name                 = "dsk-${var.vm_master_name}-os-001"
#     caching              = "ReadWrite"
#     storage_account_type = "StandardSSD_LRS"
#   }

#   data_disks = [
#     {
#       caching              = "None"
#       disk_size_gb         = 100
#       name                 = "dsk-${var.vm_master_name}-data-001"
#       storage_account_type = "StandardSSD_LRS"
#     }
#   ]
# }

# variable "vm_worker001_name" {
#   default = "vmworker001"
# }

# module "vm_windows_worker001" {
#   source = "./azure/virtual_machine"

#   vm_name             = var.vm_worker001_name
#   environment         = module.environment.name
#   location            = module.location.name
#   resource_group_name = module.resource_group_vms.name
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
#       name                     = "nic-${var.vm_worker001_name}-001",
#       vnet_resource_group_name = module.resource_group_cluster.name
#       vnet_name                = "vnet-dev-westeu-1001"
#       subnet_name              = "snet-virtualmachines-001"
#     },
#   ]

#   os_disk = {
#     name                 = "dsk-${var.vm_worker001_name}-os-001"
#     caching              = "ReadWrite"
#     storage_account_type = "StandardSSD_LRS"
#   }

#   data_disks = [
#     {
#       caching              = "None"
#       disk_size_gb         = 100
#       name                 = "dsk-${var.vm_worker001_name}-data-001"
#       storage_account_type = "StandardSSD_LRS"
#     }
#   ]
# }

# ### vpn gateway
# module "resource_group_vpn_gateway" {
#   source      = "./azure/resource_group"
#   name        = "tf-filipe-vpn-gateway"
#   location    = module.location.name
#   environment = module.environment.name
# }

# module "vnet_vpn_gateway" {
#   source              = "./azure/virtual_network"
#   resource_group_name = module.resource_group_vpn_gateway.name
#   name                = "vnet-dev-westeu-1002"
#   address_spaces      = ["10.113.0.0/16"]
#   environment         = module.environment.name
#   location            = module.location.name
#   subnets = [
#     {
#       name                                          = "GatewaySubnet"
#       address_prefixes                              = ["10.113.2.0/24"]
#       private_link_service_network_policies_enabled = false
#       private_endpoint_network_policies_enabled     = false
#       service_endpoints                             = []
#       delegations                                   = []
#     }
#   ]
#   depends_on = [module.resource_group_vpn_gateway]
# }

# module "vpn_gateway" {
#   source                   = "./azure/vpn_gateway"
#   name                     = "testvpn"
#   environment              = module.environment.name
#   location                 = module.location.name
#   resource_group_name      = module.resource_group_vpn_gateway.name
#   vnet_resource_group_name = module.resource_group_vpn_gateway.name
#   vnet_name                = "vnet-dev-westeu-1002"
#   address_spaces           = ["10.156.80.0/24"]
# }


# # vnet peering
# module "peering_vnet-dev-westeu-1001_to_vpn_gateway" {
#   source = "./azure/virtual_network_peering"
#   vnet_source = {
#     name                         = module.vnet_cluster.name
#     resource_group_name          = module.resource_group_cluster.name
#     allow_forwarded_traffic      = true
#     allow_gateway_transit        = true
#     allow_virtual_network_access = true
#     use_remote_gateways          = true
#   }
#   vnet_destination = {
#     name                         = module.vnet_vpn_gateway.name
#     resource_group_name          = module.resource_group_vpn_gateway.name
#     allow_forwarded_traffic      = true
#     allow_gateway_transit        = true
#     allow_virtual_network_access = true
#     use_remote_gateways          = false
#   }
# }

# output "virtual_machine_password" {
#   sensitive = true
#   value     = module.vm_windows_master.admin_password
# }
