# Azure Container Registry Module

This module creates an Azure Container Registry with flexible naming options and SKU-based configuration.

## Features

- **Flexible Naming**: Supports both automatic naming and manual override
- **SKU-based Configuration**: Automatic handling of network rules based on SKU tier
- **Global Uniqueness**: Uses company_prefix + workload + environment for naming
- **Validation**: Comprehensive lifecycle preconditions for naming and SKU compatibility
- **Security**: Disabled admin access and public network access by default

## Naming Convention

### Automatic Naming
- **Pattern**: `cr{company_prefix}{workload}{environment}`
- **Example**: `crnmbrscontosoprod`
- **Note**: No dashes allowed (Azure restriction)
- **Uniqueness**: Relies on company_prefix + workload + environment combination

### Override Naming
- Use `override_name` to bypass automatic naming
- Must be globally unique across all Azure subscriptions
- Must follow Azure naming rules for container registries

## Usage Examples

### Example 1: Premium SKU with Private Access
```hcl
module "container_registry" {
  source = "../../modules/azure/container_registry"

  workload            = "contoso"
  resource_group_name = "rg-containerimages-prod"
  location            = "westeurope"
  environment         = "prod"
  company_prefix      = "nmbrs"

  sku_name                                  = "Premium"
  admin_enabled                             = false
  public_network_access_enabled             = false
  trusted_services_bypass_firewall_enabled  = true
}
```

### Example 2: Basic SKU (Public Access Only)
```hcl
module "container_registry" {
  source = "../../modules/azure/container_registry"

  workload            = "appimages"
  resource_group_name = "rg-containerimages-dev"
  location            = "westeurope"
  environment         = "dev"
  company_prefix      = "nmbrs"

  sku_name      = "Basic"
  admin_enabled = false

  # Note: public_network_access_enabled is automatically set to true for Basic SKU
  # Note: trusted_services_bypass_firewall_enabled must be false for Basic SKU
  public_network_access_enabled            = true
  trusted_services_bypass_firewall_enabled = false
}
```

### Example 3: With Override Name
```hcl
module "container_registry" {
  source = "../../modules/azure/container_registry"

  override_name       = "crcustomname12345"
  resource_group_name = "rg-containerimages-test"
  location            = "westeurope"
  environment         = "test"

  sku_name                                  = "Premium"
  admin_enabled                             = false
  public_network_access_enabled             = false
  trusted_services_bypass_firewall_enabled  = true
}
```

### Example 4: Standard SKU with Admin Enabled
```hcl
module "container_registry" {
  source = "../../modules/azure/container_registry"

  workload            = "legacyapp"
  resource_group_name = "rg-containerimages-sand"
  location            = "northeurope"
  environment         = "sand"
  company_prefix      = "nmbrs"

  sku_name      = "Standard"
  admin_enabled = true

  # Note: public_network_access_enabled must be true for Standard SKU
  public_network_access_enabled            = true
  trusted_services_bypass_firewall_enabled = false
}
```

## SKU Differences

### Basic SKU
- **Public Network Access**: Always enabled (cannot be disabled)
- **Network Rules**: Not supported
- **Trusted Services Bypass**: Must be set to `false`

### Standard SKU
- **Public Network Access**: Always enabled (cannot be disabled)
- **Network Rules**: Not supported
- **Trusted Services Bypass**: Must be set to `false`

### Premium SKU
- **Public Network Access**: Can be enabled or disabled
- **Network Rules**: Fully supported
- **Trusted Services Bypass**: Can be enabled or disabled
- **Additional Features**: Private endpoints, customer-managed keys, geo-replication

## Variables

### Required Variables

| Name | Type | Description |
|------|------|-------------|
| `resource_group_name` | string | The name of an existing Resource Group |
| `location` | string | The Azure region for deployment |
| `environment` | string | Environment (dev, test, prod, sand, stag) |
| `sku_name` | string | SKU tier (Basic, Standard, Premium) |

### Optional Variables

| Name | Type | Default | Description |
|------|------|---------|-------------|
| `workload` | string | null | Workload name (required if override_name not provided) |
| `company_prefix` | string | null | Company prefix, 1-5 chars (required if override_name not provided) |
| `override_name` | string | null | Override automatic naming |
| `admin_enabled` | bool | false | Enable admin user account |
| `public_network_access_enabled` | bool | false | Enable public network access (Premium only) |
| `trusted_services_bypass_firewall_enabled` | bool | true | Allow trusted Azure services to bypass firewall |

## Outputs

| Name | Description | Sensitive |
|------|-------------|-----------|
| `id` | The ID of the Container Registry | No |
| `name` | The name of the Container Registry | No |
| `login_server` | The URL for logging into the registry | No |
| `admin_username` | Admin username | Yes |
| `admin_password` | Admin password | Yes |
| `identity` | Identity block of the registry | No |

## Validation Rules

### Naming Validation
- Either `override_name` must be provided, OR both `workload` and `company_prefix` must be provided
- `workload` must be 1-13 characters (letters and numbers only)
- `company_prefix` must be 1-5 characters

### SKU Validation
- `public_network_access_enabled` can only be `false` with Premium SKU
- `trusted_services_bypass_firewall_enabled` can only be `true` with Premium SKU
- For Basic/Standard SKUs, these options are automatically configured

## Notes

- Container Registry names must be globally unique across all Azure subscriptions
- Container Registry names cannot contain dashes or special characters
- Admin access is disabled by default for security
- Public network access is disabled by default (Premium SKU)
- Tags are managed externally (lifecycle ignore_changes)

## References

- [Azure Container Registry Documentation](https://learn.microsoft.com/en-us/azure/container-registry/)
- [Azure Container Registry SKU Comparison](https://learn.microsoft.com/en-us/azure/container-registry/container-registry-skus)
- [Terraform azurerm_container_registry](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_registry)
