data "azurerm_subscription" "current" {}

data "azurerm_resource_group" "network" {
  name = var.resource_group_name
}

locals {
  location = data.azurerm_resource_group.network.location
  tags     = data.azurerm_resource_group.network.tags
}

resource "azurerm_virtual_network" "vnets" {
  for_each            = var.virtual_networks
  name                = "vnet-${each.value["prefix"]}-${each.value["id"]}"
  location            = local.location
  resource_group_name = data.azurerm_resource_group.network.name
  address_space       = each.value["address_space"]

  tags = local.tags
}

resource "azurerm_subnet" "vnet" {
  for_each             = var.subnets
  name                 = each.key
  resource_group_name  = data.azurerm_resource_group.network.name
  address_prefixes     = each.value["address_prefixes"]

  depends_on           = [azurerm_virtual_network.vnets]
  #virtual_network_name = "vnet-${lookup(var.virtual_networks, each.value["vnet_key"], "wrong_vnet_key_in_vnets")["prefix"]}-${lookup(var.virtual_networks, each.value["vnet_key"], "wrong_vnet_key_in_vnets")["id"]}"
  virtual_network_name      = lookup(azurerm_virtual_network.vnets, each.value["vnet_key"], null)["name"]

  dynamic "delegation" {
    for_each = lookup(each.value, "delegation", [])
    content {
      name = lookup(delegation.value, "name", null)
      dynamic "service_delegation" {
        for_each = lookup(delegation.value, "service_delegation", [])
        content {
          name    = lookup(service_delegation.value, "name", null)    # (Required) The name of service to delegate to. Possible values include Microsoft.BareMetal/AzureVMware, Microsoft.BareMetal/CrayServers, Microsoft.Batch/batchAccounts, Microsoft.ContainerInstance/containerGroups, Microsoft.Databricks/workspaces, Microsoft.HardwareSecurityModules/dedicatedHSMs, Microsoft.Logic/integrationServiceEnvironments, Microsoft.Netapp/volumes, Microsoft.ServiceFabricMesh/networks, Microsoft.Sql/managedInstances, Microsoft.Sql/servers, Microsoft.Web/hostingEnvironments and Microsoft.Web/serverFarms.
          actions = lookup(service_delegation.value, "actions", null) # (Required) A list of Actions which should be delegated. Possible values include Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action, Microsoft.Network/virtualNetworks/subnets/action and Microsoft.Network/virtualNetworks/subnets/join/action.
        }
      }
    }
  }
}

resource "azurerm_virtual_network_peering" "peers" {
  for_each                     = var.vnets_to_peer
  resource_group_name          = data.azurerm_resource_group.network.name
  remote_virtual_network_id    = "/subscriptions/${data.azurerm_subscription.current.subscription_id}/resourceGroups/${each.value["remote_vnet_rg_name"]}/providers/Microsoft.Network/virtualNetworks/${each.value["remote_vnet_name"]}"
  allow_virtual_network_access = lookup(each.value, "allow_virtual_network_access", null) #(Optional) Controls if the VMs in the remote virtual network can access VMs in the local virtual network. Defaults to false.
  allow_forwarded_traffic      = lookup(each.value, "allow_forwarded_traffic", null)      #(Optional) Controls if forwarded traffic from VMs in the remote virtual network is allowed. Defaults to false.
  allow_gateway_transit        = lookup(each.value, "allow_gateway_transit", null)        #(Optional) Controls gatewayLinks can be used in the remote virtual network’s link to the local virtual network.
  use_remote_gateways          = lookup(each.value, "use_remote_gateways", null)          #(Optional) Controls if remote gateways can be used on the local virtual network. If the flag is set to true, and allow_gateway_transit on the remote peering is also true, virtual network will use gateways of remote virtual network for transit. Only one peering can have this flag set to true. This flag cannot be set if virtual network already has a gateway. Defaults to false.

  name                         = "${lookup(azurerm_virtual_network.vnets, each.value["vnet_key"], null)["name"]}_to_${each.value["remote_vnet_name"]}"
  virtual_network_name         = lookup(azurerm_virtual_network.vnets, each.value["vnet_key"], null)["name"]
}