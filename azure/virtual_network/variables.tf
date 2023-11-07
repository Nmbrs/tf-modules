variable "resource_group_name" {
  description = "The name of the resource group in which to create the virtual network."
  type        = string
}

variable "workload" {
  description = "The workload name of the virtual network."
  type        = string
}

variable "location" {
  description = "The location where the resources will be deployed in Azure. For an exaustive list of locations, please use the command 'az account list-locations -o table'."
  type        = string
}

variable "environment" {
  description = "The environment in which the resource should be provisioned."
  type        = string
}

variable "address_spaces" {
  description = "The address space that is used the virtual network."
  type        = list(string)
  default     = []

  validation {
    condition     = alltrue([for address_space in var.address_spaces : can(cidrhost(address_space, 0))])
    error_message = "At least one of the values from 'address_spaces' property is invalid. They must be valid CIDR blocks."
  }

  validation {
    condition     = length(var.address_spaces) > 0
    error_message = "The 'address_spaces' property is an invalid list. The list must have at least one element."
  }

  validation {
    condition     = length(var.address_spaces) == length(distinct(var.address_spaces))
    error_message = "At least one of the values from 'address_spaces' list is duplicated. All elements must be unique."
  }
}

variable "subnets" {
  description = "List of objects that represent the configuration of each subnet."
  type = list(object({
    name = string
    # instance_count                                = number
    address_prefixes                              = list(string)
    delegations                                   = list(string)
    private_link_service_network_policies_enabled = bool
    private_endpoint_network_policies_enabled     = bool
    service_endpoints                             = list(string)

  }))
  default = []

  validation {
    condition     = alltrue([for subnet in var.subnets : can(coalesce(subnet.name))])
    error_message = "At least one 'name' property from 'subnets' is invalid. They must be non-empty string values."
  }

  validation {
    condition     = length([for subnet in var.subnets : subnet.name]) == length(distinct([for subnet in var.subnets : subnet.name]))
    error_message = "At least one 'name' property from one of the 'subnets' is duplicated. They must be unique."
  }

  validation {
    condition     = alltrue([for subnet in var.subnets : alltrue([for address_prefix in subnet.address_prefixes : can(cidrhost(address_prefix, 0))])])
    error_message = "At least one of the values from 'address_prefixes' property from one of the 'subnets' is invalid. They must be valid CIDR blocks."
  }

  validation {
    condition     = alltrue([for subnet in var.subnets : length(subnet.address_prefixes) > 0])
    error_message = "At least one 'address_prefixes' property from one of the 'subnets' is an invalid list. They must have at least one element."
  }

  validation {
    condition     = alltrue([for subnet in var.subnets : length(subnet.address_prefixes) == length(distinct(subnet.address_prefixes))])
    error_message = "At least one of the values from 'address_prefixes' list from one of the 'subnets' is duplicated. All elements must be unique."
  }

  validation {
    condition = alltrue([
      for subnet in var.subnets : alltrue([
        for service_endpoint in subnet.service_endpoints : contains(
          [
            "Microsoft.AzureActiveDirectory",
            "Microsoft.AzureCosmosDB",
            "Microsoft.ContainerRegistry",
            "Microsoft.EventHub",
            "Microsoft.KeyVault",
            "Microsoft.ServiceBus",
            "Microsoft.Sql",
            "Microsoft.Storage",
            "Microsoft.Web"
          ],
        service_endpoint)
      ])
    ])
    error_message = "At least one of the values from 'service_endpoint' property from one of the 'subnets' is invalid. Valid options are 'Microsoft.AzureActiveDirectory', 'Microsoft.AzureCosmosDB', 'Microsoft.ContainerRegistry', 'Microsoft.EventHub', 'Microsoft.KeyVault', 'Microsoft.ServiceBus', 'Microsoft.Sql', 'Microsoft.Storage', 'Microsoft.Web'."
  }

  validation {
    condition     = alltrue([for subnet in var.subnets : length(subnet.service_endpoints) == length(distinct(subnet.service_endpoints))])
    error_message = "At least one of the values from 'service_endpoints' list from one of the 'subnets' is duplicated. All elements must be unique."
  }

  validation {
    condition = alltrue([
      for subnet in var.subnets : alltrue([
        for delegation in subnet.delegations : contains(
          [
            "Microsoft.AISupercomputer/accounts/jobs",
            "Microsoft.AISupercomputer/accounts/models",
            "Microsoft.AISupercomputer/accounts/npu",
            "Microsoft.ApiManagement/service",
            "Microsoft.Apollo/npu",
            "Microsoft.App/environments",
            "Microsoft.App/testClients",
            "Microsoft.AVS/PrivateClouds",
            "Microsoft.AzureCosmosDB/clusters",
            "Microsoft.BareMetal/AzureHostedService",
            "Microsoft.BareMetal/AzureVMware",
            "Microsoft.BareMetal/CrayServers",
            "Microsoft.Batch/batchAccounts",
            "Microsoft.CloudTest/hostedpools",
            "Microsoft.CloudTest/images",
            "Microsoft.CloudTest/pools",
            "Microsoft.Codespaces/plans",
            "Microsoft.ContainerInstance/containerGroups",
            "Microsoft.ContainerService/managedClusters",
            "Microsoft.DBforMySQL/flexibleServers",
            "Microsoft.DBforMySQL/serversv2",
            "Microsoft.DBforPostgreSQL/flexibleServers",
            "Microsoft.DBforPostgreSQL/serversv2",
            "Microsoft.DBforPostgreSQL/singleServers",
            "Microsoft.Databricks/workspaces",
            "Microsoft.DelegatedNetwork/controller",
            "Microsoft.DevCenter/networkConnection",
            "Microsoft.DocumentDB/cassandraClusters",
            "Microsoft.Fidalgo/networkSettings",
            "Microsoft.HardwareSecurityModules/dedicatedHSMs",
            "Microsoft.Kusto/clusters",
            "Microsoft.LabServices/labplans",
            "Microsoft.Logic/integrationServiceEnvironments",
            "Microsoft.MachineLearningServices/workspaces",
            "Microsoft.Netapp/volumes",
            "Microsoft.Network/dnsResolvers",
            "Microsoft.Orbital/orbitalGateways",
            "Microsoft.PowerPlatform/enterprisePolicies",
            "Microsoft.PowerPlatform/vnetaccesslinks",
            "Microsoft.ServiceFabricMesh/networks",
            "Microsoft.Singularity/accounts/jobs",
            "Microsoft.Singularity/accounts/models",
            "Microsoft.Singularity/accounts/npu",
            "Microsoft.Sql/managedInstances",
            "Microsoft.StoragePool/diskPools",
            "Microsoft.StreamAnalytics/streamingJobs",
            "Microsoft.Synapse/workspaces",
            "Microsoft.Web/hostingEnvironments",
            "Microsoft.Web/serverFarms",
            "NGINX.NGINXPLUS/nginxDeployments",
            "PaloAltoNetworks.Cloudngfw/firewalls",
            "Qumulo.Storage/fileSystems"
          ],
        delegation)
      ])
    ])
    error_message = "At least one of the values from 'delegations' property from one of the 'subnets' is invalid. Valid options are 'Microsoft.AISupercomputer/accounts/jobs', 'Microsoft.AISupercomputer/accounts/models', 'Microsoft.AISupercomputer/accounts/npu', 'Microsoft.AVS/PrivateClouds', 'Microsoft.ApiManagement/service', 'Microsoft.Apollo/npu', 'Microsoft.AzureCosmosDB/clusters', 'Microsoft.BareMetal/AzureHostedService', 'Microsoft.BareMetal/AzureVMware', 'Microsoft.BareMetal/CrayServers', 'Microsoft.Batch/batchAccounts', 'Microsoft.CloudTest/hostedpools', 'Microsoft.CloudTest/images', 'Microsoft.CloudTest/pools', 'Microsoft.Codespaces/plans', 'Microsoft.ContainerInstance/containerGroups', 'Microsoft.ContainerService/managedClusters', 'Microsoft.DBforMySQL/flexibleServers', 'Microsoft.DBforMySQL/serversv2', 'Microsoft.DBforPostgreSQL/flexibleServers', 'Microsoft.DBforPostgreSQL/serversv2', 'Microsoft.DBforPostgreSQL/singleServers', 'Microsoft.Databricks/workspaces', 'Microsoft.DelegatedNetwork/controller', 'Microsoft.DevCenter/networkConnection', 'Microsoft.DocumentDB/cassandraClusters', 'Microsoft.Fidalgo/networkSettings', 'Microsoft.HardwareSecurityModules/dedicatedHSMs', 'Microsoft.Kusto/clusters', 'Microsoft.LabServices/labplans', 'Microsoft.Logic/integrationServiceEnvironments', 'Microsoft.MachineLearningServices/workspaces', 'Microsoft.Netapp/volumes', 'Microsoft.Network/dnsResolvers', 'Microsoft.Orbital/orbitalGateways', 'Microsoft.PowerPlatform/enterprisePolicies', 'Microsoft.PowerPlatform/vnetaccesslinks', 'Microsoft.ServiceFabricMesh/networks', 'Microsoft.Singularity/accounts/jobs', 'Microsoft.Singularity/accounts/models', 'Microsoft.Singularity/accounts/npu', 'Microsoft.Sql/managedInstances', 'Microsoft.StoragePool/diskPools', 'Microsoft.StreamAnalytics/streamingJobs', 'Microsoft.Synapse/workspaces', 'Microsoft.Web/hostingEnvironments', 'Microsoft.Web/serverFarms', 'NGINX.NGINXPLUS/nginxDeployments', 'PaloAltoNetworks.Cloudngfw/firewalls'."
  }

  validation {
    condition     = alltrue([for subnet in var.subnets : length(subnet.delegations) == length(distinct(subnet.delegations))])
    error_message = "At least one of the values from 'delegations' list from one of the 'subnets' is duplicated. All elements must be unique."
  }
}

variable "instance_count" {
  type        = number
  description = "A numeric sequence number used for naming the resource. It ensures a unique identifier for each resource instance in the naming convention."

  validation {
    condition     = var.instance_count >= 1 && var.instance_count <= 999
    error_message = format("Invalid value '%s' for variable 'instance_count'. It must be between 1 and 999.", var.instance_count)
  }
}

