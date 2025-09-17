# AKS Module

<p>
  <img alt="Version" src="https://img.shields.io/badge/version-1.0.0-blue.svg" />
  <a href="LICENSE.md" target="_blank">
    <img alt="License: MIT" src="https://img.shields.io/badge/License-MIT-blue.svg" />
  </a>
</p>

---

> A terraform module to create a private AKS cluster in Azure.

## Module Input variables

- `name` - (Required) The name of the Managed Kubernetes Cluster to create. Changing this forces a new resource to be created.

- `location` - (Required) The location where the Managed Kubernetes Cluster should be created. Changing this forces a new resource to be created.

- `resource_group_name` - (Required) Specifies the Resource Group where the Managed Kubernetes Cluster should exist. Changing this forces a new resource to be created.

- `tags` - (Optional) A mapping of tags to assign to the resource.

- `kubernetes_version` - (Optional) Version of Kubernetes specified when creating the AKS managed cluster. If not specified, the latest recommended version will be used at provisioning time (but won't auto-upgrade).

- `dns_prefix` - (Optional) DNS prefix specified when creating the managed cluster. Changing this forces a new resource to be created.

- `automatic_channel_upgrade` - (Optional) The upgrade channel for this Kubernetes Cluster. Possible values are patch, rapid, node-image and stable. Omitting this field sets this value to none.

- `sku_tier` - (Optional) The SKU Tier that should be used for this Kubernetes Cluster. Possible values are Free and Paid (which includes the Uptime SLA). Defaults to Free.

- `default_node_pool_name` - (Required) The name which should be used for the default Kubernetes Node Pool. Changing this forces a new resource to be created.

- `default_node_pool_vm_size` - (Required) The size of the Virtual Machine, such as Standard_DS2_v2.

- `vnet_subnet_id` - (Optional) The ID of a Subnet where the Kubernetes Node Pool should exist. Changing this forces a new resource to be created.

- `default_node_pool_availability_zones` - (Optional) A list of Availability Zones across which the Node Pool should be spread. Changing this forces a new resource to be created.

- `default_node_pool_node_labels` - (Optional) A map of Kubernetes labels which should be applied to nodes in the Default Node Pool. Changing this forces a new resource to be created.

- `default_node_pool_enable_auto_scaling` - (Optional) Should the Kubernetes Auto Scaler be enabled for this Node Pool?

- `default_node_pool_enable_host_encryption` - (Optional) Should the nodes in the Default Node Pool have host encryption enabled?

- `default_node_pool_enable_node_public_ip` - (Optional) Should nodes in this Node Pool have a Public IP Address?

- `default_node_pool_max_pods` - (Optional) The maximum number of pods that can run on each agent. Changing this forces a new resource to be created.

- `default_node_pool_max_count` - (Required) The maximum number of nodes which should exist in this Node Pool. If specified this must be between 1 and 1000.

- `default_node_pool_min_count` - (Required) The minimum number of nodes which should exist in this Node Pool. If specified this must be between 1 and 1000.

- `default_node_pool_node_count` - (Optional) The initial number of nodes which should exist in this Node Pool. If specified this must be between 1 and 1000 and between min_count and max_count. 

- `default_node_pool_os_disk_type` - (Optional) The type of disk which should be used for the Operating System. Possible values are Ephemeral and Managed. Defaults to Managed. Changing this forces a new resource to be created.

- `network_docker_bridge_cidr` - (Optional) IP address (in CIDR notation) used as the Docker bridge IP address on nodes. Changing this forces a new resource to be created.

- `network_dns_service_ip` - (Optional) IP address within the Kubernetes service address range that will be used by cluster service discovery (kube-dns). Changing this forces a new resource to be created.

- `network_plugin` - (Required) Network plugin to use for networking. Currently supported values are azure and kubenet. Changing this forces a new resource to be created.

- `outbound_type` - (Optional) The outbound (egress) routing method which should be used for this Kubernetes Cluster. Possible values are loadBalancer, userDefinedRouting, managedNATGateway and userAssignedNATGateway. Defaults to loadBalancer.

- `network_service_cidr` - (Optional) The Network Range used by the Kubernetes service. Changing this forces a new resource to be created.

- `role_based_access_control_enabled` (Optional) - Whether Role Based Access Control for the Kubernetes Cluster should be enabled. Defaults to true. Changing this forces a new resource to be created.

- `azure_rbac_enabled` - (Optional) Is Role Based Access Control based on Azure AD enabled?

- `admin_username` - (Required) The Admin Username for the Cluster. Changing this forces a new resource to be created.

- `ssh_key` - (Required) An ssh_key block. Only one is currently allowed. Changing this forces a new resource to be created.


## Module Output Variables

see `outputs.tf` file.

## How to use it?

Fundamentally, you need to declare the module and pass the following variables in your Terraform service template:

```hcl
module "aks_cluster" {
  source                                   = "../tf-modules/azure/aks"
  name                                     = var.aks_cluster_name
  location                                 = var.location
  resource_group_name                      = azurerm_resource_group.rg.name
  tags                                     = var.tags
  kubernetes_version                       = var.kubernetes_version
  dns_prefix                               = lower(var.aks_cluster_name)
  private_cluster_enabled                  = true
  automatic_channel_upgrade                = var.automatic_channel_upgrade
  sku_tier                                 = var.sku_tier
  default_node_pool_name                   = var.default_node_pool_name
  default_node_pool_vm_size                = var.default_node_pool_vm_size
  vnet_subnet_id                           = var.subnet_id
  default_node_pool_availability_zones     = var.default_node_pool_availability_zones
  default_node_pool_node_labels            = var.default_node_pool_node_labels
  default_node_pool_node_taints            = var.default_node_pool_node_taints
  default_node_pool_enable_auto_scaling    = var.default_node_pool_enable_auto_scaling
  default_node_pool_enable_host_encryption = var.default_node_pool_enable_host_encryption
  default_node_pool_enable_node_public_ip  = var.default_node_pool_enable_node_public_ip
  default_node_pool_max_pods               = var.default_node_pool_max_pods
  default_node_pool_max_count              = var.default_node_pool_max_count
  default_node_pool_min_count              = var.default_node_pool_min_count
  default_node_pool_node_count             = var.default_node_pool_node_count
  default_node_pool_os_disk_type           = var.default_node_pool_os_disk_type
  network_docker_bridge_cidr               = var.network_docker_bridge_cidr
  network_dns_service_ip                   = var.network_dns_service_ip
  network_plugin                           = var.network_plugin
  outbound_type                            = var.outbound_type
  network_service_cidr                     = var.network_service_cidr
  role_based_access_control_enabled        = var.role_based_access_control_enabled
  azure_rbac_enabled                       = var.azure_rbac_enabled
  admin_username                           = var.admin_username
  ssh_public_key                           = var.ssh_public_key
}
```
