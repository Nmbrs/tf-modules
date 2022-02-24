resource "azurerm_virtual_network" "vnets" {
  for_each            = var.virtual_networks
  name                = "vnet-${each.value["prefix"]}"
  location            = data.azurerm_resource_group.network.location
  resource_group_name = data.azurerm_resource_group.network.name
  address_space       = each.value["address_space"]
  tags = data.azurerm_resource_group.network.tags
}

resource "azurerm_subnet" "vnet" {
  for_each            = var.subnets
  name                = "snet-${each.value["name"]}"
  resource_group_name = data.azurerm_resource_group.network.name
  address_prefixes    = each.value["address_prefixes"]

  depends_on = [azurerm_virtual_network.vnets]
  virtual_network_name = lookup(azurerm_virtual_network.vnets, each.value["vnet_key"], null)["name"]

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
  for_each                  = var.vnets_to_peer
  resource_group_name       = data.azurerm_resource_group.network.name
  remote_virtual_network_id = "/subscriptions/${data.azurerm_subscription.current.subscription_id}/resourceGroups/${data.azurerm_resource_group.network.name}/providers/Microsoft.Network/virtualNetworks/${each.value["remote_vnet_name"]}"
  name                      = "${lookup(azurerm_virtual_network.vnets, each.value["vnet_key"], null)["name"]}_to_${each.value["remote_vnet_name"]}"
  virtual_network_name      = lookup(azurerm_virtual_network.vnets, each.value["vnet_key"], null)["name"]

  depends_on = [azurerm_virtual_network.vnets]
}
