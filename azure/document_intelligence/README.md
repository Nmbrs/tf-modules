# Event Hub

## Sumary

The `document_intelligence` module is a Terraform abstraction that that implements all the necessary
Terraform code to create and manage document_intelligence form recognizer in Azure.

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5.0, < 2.0.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 3.117 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 3.117.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_cognitive_account.document_intelligence](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/cognitive_account) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_environment"></a> [environment](#input\_environment) | The environment in which the resource should be provisioned. | `string` | n/a | yes |
| <a name="input_instance_count"></a> [instance\_count](#input\_instance\_count) | The instance count of the document intelligence. | `number` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | The location where the resources will be deployed in Azure. For an exaustive list of locations, please use the command 'az account list-locations -o table'. | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | Specifies the name of the Resource Group where the resource should exist. | `string` | n/a | yes |
| <a name="input_workload"></a> [workload](#input\_workload) | The workload name of the event grid domain. | `string` | n/a | yes |

## Outputs

No outputs.

## How to use it?

A code snippet demonstrating use case for the module have been included to help you understand how to use the module in Terraform.

```hcl
resource "azurerm_cognitive_account" "document_intelligence" {
  kind                = "FormRecognizer"
  location            = westeurope
  name                = name-document-intelligence
  resource_group_name = my-rg
  sku_name            = "S0"
}
```
