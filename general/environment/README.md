# Environment Module

## Sumary

The `environment` module is an abstraction that handle the logic for selecting and validating the environment in which resources are deployed.

The environment module will take a single input variable named environment that accepts only the values dev, test, prod, and sand. The module will output a single variable named name that will contain the selected environment.

## Requirements

| Name                                                                     | Version           |
| ------------------------------------------------------------------------ | ----------------- |
| <a name="requirement_terraform"></a> [terraform](#requirement_terraform) | >= 1.3.0, < 2.0.0 |

## Providers

No providers.

## Modules

No modules.

## Resources

No resources.

## Inputs

| Name                                                               | Description                                                                                                  | Type     | Default | Required |
| ------------------------------------------------------------------ | ------------------------------------------------------------------------------------------------------------ | -------- | ------- | :------: |
| <a name="input_environment"></a> [environment](#input_environment) | The environment where the resources will be deployed. Acceptable values are 'dev', 'test', 'prod' or 'sand'. | `string` | n/a     |   yes    |

## Outputs

| Name                                            | Description                                                   |
| ----------------------------------------------- | ------------------------------------------------------------- |
| <a name="output_name"></a> [name](#output_name) | The environment selected for the deployment of the resources. |

## How to use it?

A number of code snippets demonstrating different use cases for the module have been included to help you understand how to use the module in Terraform.

```hcl
module "environment" {
  source = "git::github.com/Nmbrs/tf-modules//general/environment"
  environment = var.environment
}
```
