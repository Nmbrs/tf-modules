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
  virtual_network_name = "vnet-${lookup(var.virtual_networks, each.value["vnet_key"], "wrong_vnet_key_in_vnets")["prefix"]}-${lookup(var.virtual_networks, each.value["vnet_key"], "wrong_vnet_key_in_vnets")["id"]}"

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