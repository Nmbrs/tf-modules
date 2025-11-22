<!-- BEGIN_TF_DOCS -->
# Resource Group Module

## Summary

The `resource_group` module enables users to easily provision and configure Azure Resource Group resources. It simplifies the process of setting up Resource Groups with flexible naming conventions, allowing you to define key parameters such as workload, environment, and location while maintaining infrastructure as code.

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5.0, < 2.0.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 3.117 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 3.117.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_resource_group.rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_environment"></a> [environment](#input\_environment) | The environment in which the resource should be provisioned. | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | Specifies Azure location where the resources should be provisioned. For an exhaustive list of locations, please use the command 'az account list-locations -o table'. | `string` | n/a | yes |
| <a name="input_override_name"></a> [override\_name](#input\_override\_name) | Optional override for naming logic. | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A mapping of tags which should be assigned to the desired resource. | `map(string)` | `null` | no |
| <a name="input_workload"></a> [workload](#input\_workload) | Short, descriptive name for the application, service, or workload. Used in resource naming conventions. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | The ID of the Resource Group. |
| <a name="output_location"></a> [location](#output\_location) | The Azure Region where the Resource Group exists. |
| <a name="output_name"></a> [name](#output\_name) | The Resource Group name. |
| <a name="output_tags"></a> [tags](#output\_tags) | A mapping of tags assigned to the Resource Group. |
| <a name="output_workload"></a> [workload](#output\_workload) | The resource group workload name. |

## How to use it?

A number of code snippets demonstrating different use cases for the module have been included to help you understand how to use the module in Terraform.

### Basic usage with automatic naming

```hcl
module "resource_group" {
  source      = "./azure/resource_group"
  workload    = "contoso"
  environment = "dev"
  location    = "westeurope"

  tags = {
    managed_by  = "terraform"
    environment = "dev"
    product     = "internal"
    category    = "monolith"
    owner       = "infra"
    country     = "nl"
    status      = "life_cycle"
    service     = "payroll"
  }
}

# Output: rg-contoso-dev
```

### Minimal usage without tags

```hcl
module "resource_group" {
  source      = "./azure/resource_group"
  workload    = "myapp"
  environment = "dev"
  location    = "westeurope"
}

# Output: rg-myapp-dev
# Note: Tags are optional and can be omitted entirely
```

### Production environment example

```hcl
module "resource_group" {
  source      = "./azure/resource_group"
  workload    = "payroll"
  environment = "prod"
  location    = "westeurope"

  tags = {
    managed_by  = "terraform"
    environment = "prod"
    product     = "external"
    owner       = "platform"
    criticality = "high"
  }
}

# Output: rg-payroll-prod
```

### Custom naming with override

```hcl
module "resource_group" {
  source        = "./azure/resource_group"
  override_name = "rg-custom-legacy-prod"
  environment   = "prod"
  location      = "westeurope"

  tags = {
    managed_by = "terraform"
    legacy     = "true"
  }
}

# Output: rg-custom-legacy-prod
```

### Multiple resource groups for different workloads

```hcl
module "resource_group_app" {
  source      = "./azure/resource_group"
  workload    = "app"
  environment = "prod"
  location    = "westeurope"

  tags = {
    managed_by = "terraform"
    tier       = "application"
  }
}

module "resource_group_data" {
  source      = "./azure/resource_group"
  workload    = "data"
  environment = "prod"
  location    = "westeurope"

  tags = {
    managed_by = "terraform"
    tier       = "data"
  }
}

# Outputs:
# rg-app-prod
# rg-data-prod
```

## Naming Conventions

The module supports two naming approaches:

### Automatic Naming
- **Format**: `rg-{workload}-{environment}`
- **Example**: `rg-contoso-dev`
- Resource groups are self-contained workloads that don't require sequence numbers for capacity scaling

### Custom Naming
- Provide `override_name` to use a custom name
- When using `override_name`, `workload` is optional
- **Example**: `rg-custom-legacy-prod`
- Useful for migrating existing resource groups or maintaining legacy naming conventions

## Lifecycle Management

The module uses `ignore_changes = [tags]` to prevent Terraform from detecting drift in tags after the resource group is created. This allows tags to be managed outside of Terraform without causing plan changes.

## Validation

The module includes comprehensive validation:

1. **Environment**: Must be one of: `dev`, `test`, `prod`, `sand`, `stag`
2. **Location**: Must be a non-empty string
3. **Naming Logic**: Either `override_name` or `workload` must be provided
4. **Tags**: Optional. When provided, all tag values must be non-empty strings

<!-- END_TF_DOCS -->
