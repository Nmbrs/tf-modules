# Application Gateway

## Summary

The `application_gateway` module enables users to easily provision and configure Azure Application Gateway resources for entry points of traffic and load balancing to the apps. It simplifies the process of setting up Application Gateway, allowing you to define key parameters such as resource name, location, etc all while maintaining infrastructure as code.

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
| [azurerm_application_gateway.app_gw](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/application_gateway) | resource |
| [azurerm_public_ip.app_gw](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/public_ip) | resource |
| [azurerm_key_vault.certificate](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault) | data source |
| [azurerm_key_vault_secret.certificate](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret) | data source |
| [azurerm_subnet.app_gw](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subnet) | data source |
| [azurerm_user_assigned_identity.certificate](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/user_assigned_identity) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_application_settings"></a> [application\_settings](#input\_application\_settings) | The values of the application that the application gateway will serve | <pre>list(object({<br>    listener_fqdn    = string<br>    backend_fqdn     = string<br>    rule_priority    = number<br>    protocol         = string<br>    certificate_name = optional(string, null)<br>    health_probe = object({<br>      timeout_in_seconds             = number<br>      evaluation_interval_in_seconds = number<br>      unhealthy_treshold_count       = number<br>      path                           = string<br>      port                           = number<br>      protocol                       = string<br>    })<br>  }))</pre> | `[]` | no |
| <a name="input_certificates"></a> [certificates](#input\_certificates) | n/a | <pre>list(object({<br>    name                          = string<br>    key_vault_name                = string<br>    key_vault_resource_group_name = string<br>    key_vault_certificate_name    = string<br>  }))</pre> | `[]` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | The environment in which the resource should be provisioned. | `string` | n/a | yes |
| <a name="input_instance_count"></a> [instance\_count](#input\_instance\_count) | The number of the app gw in case you have more than one | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | The location where the resources will be deployed in Azure. For an exaustive list of locations, please use the command 'az account list-locations -o table'. | `string` | n/a | yes |
| <a name="input_managed_identity_settings"></a> [managed\_identity\_settings](#input\_managed\_identity\_settings) | n/a | <pre>object({<br>    name                = string<br>    resource_group_name = string<br>  })</pre> | n/a | yes |
| <a name="input_max_instance_count"></a> [max\_instance\_count](#input\_max\_instance\_count) | Maximum value of instances the application gateway will have | `number` | `10` | no |
| <a name="input_min_instance_count"></a> [min\_instance\_count](#input\_min\_instance\_count) | Minimum value of instances the application gateway will have | `number` | `2` | no |
| <a name="input_network_settings"></a> [network\_settings](#input\_network\_settings) | n/a | <pre>object({<br>    vnet_name                = string<br>    vnet_resource_group_name = string<br>    subnet_name              = string<br>  })</pre> | n/a | yes |
| <a name="input_redirect_settings"></a> [redirect\_settings](#input\_redirect\_settings) | The values of the application that the application gateway will serve | <pre>list(object({<br>    listener_fqdn    = string<br>    target_url       = string<br>    rule_priority    = number<br>    protocol         = string<br>    certificate_name = optional(string, null)<br>  }))</pre> | `[]` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of an existing Resource Group. | `string` | n/a | yes |
| <a name="input_workload"></a> [workload](#input\_workload) | The workload destined for the app gateway | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | The application gateway  gateway  ID. |
| <a name="output_name"></a> [name](#output\_name) | The application gateway full name. |
| <a name="output_public_ip_address"></a> [public\_ip\_address](#output\_public\_ip\_address) | Output of the public IP address |
| <a name="output_public_ip_fqdn"></a> [public\_ip\_fqdn](#output\_public\_ip\_fqdn) | Output of the public IP FQDN |
| <a name="output_workload"></a> [workload](#output\_workload) | The application gateway workload name. |
## How to use it?

A number of code snippets demonstrating different use cases for the module have been included to help you understand how to use the module in Terraform.

## Application Gateway with multiple applications

```hcl
module "application_gateway" {
  source              = "./azure/application_gateway"
  workload            = "your_workload"
  resource_group_name = "resource-group"
  instance_count      = "1"
  environment         = "dev"
  location            = "westeurope"
  min_instance_count  = "2"
  max_instance_count  = "10"

  network_settings = {
    vnet_name                = "virtual_network_name"
    vnet_resource_group_name = "rg-vnet-001"
    subnet_name              = "snet-appgateway-001"
  }

  managed_identity_settings = {
    name                = "my-managed-identity"
    resource_group_name = "rg-managed-identity"
  }

  certificates = [
    {
      key_vault_resource_group_name = "rg-kv-001"
      key_vault_name                = "kv-001"
      key_vault_certificate_name    = "wildcard-contoso-com"
      name                          = "contoso-com"
    }
  ]

  application_settings = [
    {
      listener_fqdn    = "app1.contoso.com"
      backend_fqdn     = "app1.azurewebsites.net"
      rule_priority    = 1
      protocol         = "https"
      certificate_name = "contoso-com"
      health_probe = {
        timeout_in_seconds             = 30
        evaluation_interval_in_seconds = 30
        unhealthy_treshold_count       = 3
        path                           = "/health"
        port                           = 443
        protocol                       = "https"
      }
    },
    {
      listener_fqdn    = "app2.contoso.com"
      backend_fqdn     = "app2.azurewebsites.net"
      rule_priority    = 1
      protocol         = "https"
      certificate_name = "contoso-com"
      health_probe = {
        timeout_in_seconds             = 30
        evaluation_interval_in_seconds = 30
        unhealthy_treshold_count       = 3
        path                           = "/health"
        port                           = 443
        protocol                       = "https"
      }
    }
  ]
}
```

## Application Gateway with URL redirects

```hcl
module "application_gateway" {
  source              = "./azure/application_gateway"
  workload            = "your_workload"
  resource_group_name = "resource-group"
  instance_count      = "1"
  environment         = "dev"
  location            = "westeurope"
  min_instance_count  = "2"
  max_instance_count  = "10"

  network_settings = {
    vnet_name                = "virtual_network_name"
    vnet_resource_group_name = "rg-vnet-001"
    subnet_name              = "snet-appgateway-001"
  }

  managed_identity_settings = {
    name                = "my-managed-identity"
    resource_group_name = "rg-managed-identity"
  }

  certificates = [
    {
      key_vault_resource_group_name = "rg-kv-001"
      key_vault_name                = "kv-001"
      key_vault_certificate_name    = "wildcard-contoso-com"
      name                          = "contoso-com"
    }
  ]

  redirect_settings = [
    {
      listener_fqdn    = "www.contoso.com"
      target_url       = "https://contoso.com/business"
      rule_priority    = 1
      protocol         = "https"
      certificate_name = "contoso-com"
    },
    {
      listener_fqdn    = "mail.contoso.com"
      target_url       = "https://www.mail.contoso.com"
      rule_priority    = 2
      protocol         = "https"
      certificate_name = "contoso-com"
    },
        {
      listener_fqdn    = "*.contoso.com"
      target_url       = "https://app.contoso.com"
      rule_priority    = 20000
      protocol         = "https"
    certificate_name = "contoso-com"
    }
  ]
}
```

## Applicaton Gateway with multiple certificates configured


```hcl
module "application_gateway" {
  source              = "./azure/application_gateway"
  workload            = "your_workload"
  resource_group_name = "resource-group"
  instance_count      = "1"
  environment         = "dev"
  location            = "westeurope"
  min_instance_count  = "2"
  max_instance_count  = "10"

  network_settings = {
    vnet_name                = "virtual_network_name"
    vnet_resource_group_name = "rg-vnet-001"
    subnet_name              = "snet-appgateway-001"
  }

  managed_identity_settings = {
    name                = "my-managed-identity"
    resource_group_name = "rg-managed-identity"
  }

  certificates = [
    {
      key_vault_resource_group_name = "rg-kv-001"
      key_vault_name                = "kv-001"
      key_vault_certificate_name    = "wildcard-contoso-com"
      name                          = "contoso-com"
    },
        {
      key_vault_resource_group_name = "rg-kv-002"
      key_vault_name                = "kv-002"
      key_vault_certificate_name    = "wildcard-mydomain-com"
      name                          = "mydomain-com"
    }
  ]
}
```