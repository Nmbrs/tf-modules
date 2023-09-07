# Cosmos DB Module

## Summary


The `cosmos_db` module is designed to simplify the deployment and management of Azure Cosmos DB instances, a fully managed NoSQL and relational database solution tailor-made for modern application development. This module ensures an effortless and consistent approach to creating and overseeing Azure Cosmos DB resources while enforcing organization-specific policies and compliance standards.

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5.0, < 2.0.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 3.70 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | ~> 3.70 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_cosmodb_account.cosmo_db](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/cosmodb_account) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_kind"></a> [kind](#input\_kind) | defines the Kind of CosmosDB to create. | `string` | n/a | yes |
| <a name="input_mongo_db_version"></a> [mongo\_db\_version](#input\_mongo\_db\_version) | (Optional) The Server Version of a MongoDB account. Possible values are 4.2, 4.0, 3.6, and 3.2. | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | (Required) Specifies the name of the resource. | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of an existing Resource Group. | `string` | n/a | yes |

## Outputs

No outputs.

## How to use it?

A number of code snippets demonstrating different use cases for the module have been included to help you understand how to use the module in Terraform.

## Mongo DB mode

```hcl
module "cosmos_mongo_db" {
  source = "git::github.com/Nmbrs/tf-modules//azure/cosmos_db"
  resource_group_name = "rg-myapp"
  name                = "mymongoserver"
  environment         = "dev"
  location            = "westeurope"
  kind                = "MongoDB"
  mongo_db_version    = "4.2"
}
````
