variable "resource_group_name" {
  description = "The name of an existing Resource Group."
  type        = string
}

variable "location" {
  description = "The location where the resources will be deployed in Azure. For an exaustive list of locations, please use the command 'az account list-locations -o table'."
  type        = string
}

variable "subnet_id" {
  description = "The full Azure resource ID of the subnet where the private endpoint NIC will be created."
  type        = string
}

variable "resource_settings" {
  description = <<-EOT
    Defines the settings for the resource the private endpoint will connect to.

    - `name`: the workload identifier, used to compose the PEP name (`pep-<name>-<subresource_name>`).
    - `resource_id`: the full Azure resource ID of the target (e.g. the `.id` output of the resource's module).
    - `subresource_name`: the Azure private-link subresource (e.g. `blob`, `vault`, `sites`, `SQL`). For the full list of valid values per resource type, see:
      https://learn.microsoft.com/en-us/azure/private-link/private-endpoint-overview#private-link-resource
  EOT
  type = object(
    {
      name             = string
      resource_id      = string
      subresource_name = string
    }
  )
}

variable "private_dns_zone_id" {
  description = "Defines the private dns zone resource ID."
  type        = string
}
