<!-- BEGIN_TF_DOCS -->
# Application gateway Module

## Sumary

The `application_gateway` module enables users to easily provision and configure Azure Application Gateway resources for entry points of traffic and load balancing to the apps. It simplifies the process of setting up Application Gateway, allowing you to define key parameters such as resource name, location, etc all while maintaining infrastructure as code.


## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5.0, < 2.0.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 3.70 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 3.116.0 |

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
| [azurerm_web_application_firewall_policy.waf_policy_settings](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/web_application_firewall_policy) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_application_backend_settings"></a> [application\_backend\_settings](#input\_application\_backend\_settings) | A list of settings for the application backends that the app gateway will serve. | <pre>list(object({<br>    routing_rule = object({<br>      priority = number<br>    })<br>    listener = object({<br>      fqdn             = string<br>      protocol         = string<br>      certificate_name = optional(string, null)<br>    })<br>    backend = object({<br>      fqdns                         = list(string)<br>      port                          = number<br>      protocol                      = string<br>      cookie_based_affinity_enabled = optional(bool, false)<br>      request_timeout_in_seconds    = optional(number, 30)<br>      health_probe = object({<br>        timeout_in_seconds             = number<br>        evaluation_interval_in_seconds = number<br>        unhealthy_treshold_count       = number<br>        fqdn                           = string<br>        path                           = string<br>        status_codes                   = list(string)<br>      })<br>    })<br>  }))</pre> | `[]` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | The environment in which the resource should be provisioned. | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | The location where the resources will be deployed in Azure. For an exaustive list of locations, please use the command 'az account list-locations -o table'. | `string` | n/a | yes |
| <a name="input_managed_identity_settings"></a> [managed\_identity\_settings](#input\_managed\_identity\_settings) | A list of settings related to the app gateway managed identity used to retrieve SSL certificates. | <pre>object({<br>    name                = string<br>    resource_group_name = string<br>  })</pre> | n/a | yes |
| <a name="input_max_instance_count"></a> [max\_instance\_count](#input\_max\_instance\_count) | The maximum number of instances the application gateway will have. | `number` | `10` | no |
| <a name="input_min_instance_count"></a> [min\_instance\_count](#input\_min\_instance\_count) | The minimum number of instances the application gateway will have. | `number` | `2` | no |
| <a name="input_naming_count"></a> [naming\_count](#input\_naming\_count) | A numeric sequence number used for naming the resource. It ensures a unique identifier for each resource instance within the naming convention. | `number` | n/a | yes |
| <a name="input_network_settings"></a> [network\_settings](#input\_network\_settings) | Settings related to the network connectivity of the application gateway. | <pre>object({<br>    vnet_name                = string<br>    vnet_resource_group_name = string<br>    subnet_name              = string<br>  })</pre> | n/a | yes |
| <a name="input_redirect_listener_settings"></a> [redirect\_listener\_settings](#input\_redirect\_listener\_settings) | A list of settings for the listeners redirection that the app gateway will serve. | <pre>list(object({<br>    routing_rule = object({<br>      priority = number<br>    })<br>    listener = object({<br>      fqdn             = string<br>      protocol         = string<br>      certificate_name = optional(string, null)<br>    })<br>    target = object({<br>      listener_name        = string<br>      include_path         = bool<br>      include_query_string = bool<br>    })<br>  }))</pre> | `[]` | no |
| <a name="input_redirect_url_settings"></a> [redirect\_url\_settings](#input\_redirect\_url\_settings) | A list of settings for the URL redirection that the app gateway will serve. | <pre>list(object({<br>    routing_rule = object({<br>      priority = number<br>    })<br>    listener = object({<br>      fqdn             = string<br>      protocol         = string<br>      certificate_name = optional(string, null)<br>    })<br>    target = object({<br>      url                  = string<br>      include_path         = optional(bool, false)<br>      include_query_string = optional(bool, false)<br>    })<br>  }))</pre> | `[]` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of an existing Resource Group. | `string` | n/a | yes |
| <a name="input_ssl_certificates"></a> [ssl\_certificates](#input\_ssl\_certificates) | Settings related to SSL certificates that will be installed in the application gateway. | <pre>list(object({<br>    name                          = string<br>    key_vault_name                = string<br>    key_vault_resource_group_name = string<br>    key_vault_certificate_name    = string<br>  }))</pre> | `[]` | no |
| <a name="input_waf_policy_settings"></a> [waf\_policy\_settings](#input\_waf\_policy\_settings) | Name of the WAF policy to be associated with the application gateway. | <pre>object({<br>    name                = string<br>    resource_group_name = string<br>  })</pre> | <pre>{<br>  "name": "",<br>  "resource_group_name": ""<br>}</pre> | no |
| <a name="input_workload"></a> [workload](#input\_workload) | The name of the workload associated with the resource. | `string` | n/a | yes |

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

### Configuring application backends

```hcl
module "application_gateway" {
  source              = "./azure/application_gateway"
  workload            = "your_workload"
  resource_group_name = "resource-group"
  naming_count        = "1"
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
  ssl_certificates = [
    {
      key_vault_resource_group_name = "rg-kv-001"
      key_vault_name                = "kv-001"
      key_vault_certificate_name    = "wildcard-contoso-com"
      name                          = "contoso-com"
    }
  ]
  application_backend_settings = [
    {
      routing_rule = {
        priority = 1
      }
      listener = {
        fqdn             = "app1.contoso.com"
        protocol         = "https"
        certificate_name = "contoso-com"
      }
      backend = [
        {
          fqdns                         = ["app1.azurewebsites.net", "app1.myotherdomain.com"]
          port                          = 443
          protocol                      = "https"
          cookie_based_affinity_enabled = false
          request_timeout_in_seconds    = 30
          health_probe = {
            fqdn                           = "app1.contoso.com"
            timeout_in_seconds             = 30
            evaluation_interval_in_seconds = 30
            unhealthy_treshold_count       = 3
            path                           = "/health"
            status_codes                   = ["200"]
          }
        }
      ]
    },
    {
      routing_rule = {
        priority = 2
      }
      listener = {
        fqdn             = "app2.contoso.com"
        protocol         = "https"
        certificate_name = "contoso-com"
      }
      backend = [
        {
          fqdns                         = ["app2.azurewebsites.net"]
          port                          = 443
          protocol                      = "https"
          cookie_based_affinity_enabled = false
          request_timeout_in_seconds    = 30
          health_probe = {
            fqdn                           = "app1.contoso.com"
            timeout_in_seconds             = 30
            evaluation_interval_in_seconds = 30
            unhealthy_treshold_count       = 3
            path                           = "/health"
            status_codes                   = ["200"]
          }
        }
      ]
    }
  ]
}

```

### Configuring URL redirects


```hcl
module "application_gateway" {
  source              = "./azure/application_gateway"
  workload            = "your_workload"
  resource_group_name = "resource-group"
  naming_count        = "1"
  environment         = "dev"
  location            = "westeurope"
  min_instance_count  = "2"
  max_instance_count  = "10"
  waf_policy_settings = null
  network_settings = {
    vnet_name                = "virtual_network_name"
    vnet_resource_group_name = "rg-vnet-001"
    subnet_name              = "snet-appgateway-001"
  }
  managed_identity_settings = {
    name                = "my-managed-identity"
    resource_group_name = "rg-managed-identity"
  }
  ssl_certificates = [
    {
      key_vault_resource_group_name = "rg-kv-001"
      key_vault_name                = "kv-001"
      key_vault_certificate_name    = "wildcard-contoso-com"
      name                          = "contoso-com"
    }
  ]
  redirect_url_settings = [
    {
      routing_rule = {
        priority = 3
      }
      listener = {
        fqdn             = "www.contoso.com"
        protocol         = "https"
        certificate_name = "contoso-com"
      }
      target = {
        url                  = "https://contoso.com/business"
        include_path         = true
        include_query_string = true
      }
    },
    {
      routing_rule = {
        priority = 4
      }
      listener = {
        fqdn             = "mail.contoso.com"
        protocol         = "https"
        certificate_name = "contoso-com"
      }
      target = {
        url                  = "https://www.mail.contoso.com"
        include_path         = true
        include_query_string = true
      }
    },
  ]
}
```

### Configuring listner redirects

```hcl
module "application_gateway" {
  source              = "./azure/application_gateway"
  workload            = "your_workload"
  resource_group_name = "resource-group"
  naming_count        = "1"
  environment         = "dev"
  location            = "westeurope"
  min_instance_count  = "2"
  max_instance_count  = "10"
  waf_policy_settings = {
        "name"                = "waf-name",
        "resource_group_name" = "rg-waf-policy-resource-group"
      }
  network_settings = {
    vnet_name                = "virtual_network_name"
    vnet_resource_group_name = "rg-vnet-001"
    subnet_name              = "snet-appgateway-001"
  }
  managed_identity_settings = {
    name                = "my-managed-identity"
    resource_group_name = "rg-managed-identity"
  }
  ssl_certificates = [
    {
      key_vault_resource_group_name = "rg-kv-001"
      key_vault_name                = "kv-001"
      key_vault_certificate_name    = "wildcard-contoso-com"
      name                          = "contoso-com"
    }
  ]
  application_backend_settings = [
    {
      routing_rule = {
        priority = 1
      }
      listener = {
        fqdn             = "app1.contoso.com"
        protocol         = "https"
        certificate_name = "contoso-com"
      }
      backend = [
        {
          fqdns                         = ["app1.azurewebsites.net", "app1.myotherdomain.com"]
          port                          = 443
          protocol                      = "https"
          cookie_based_affinity_enabled = false
          request_timeout_in_seconds    = 30
          health_probe = {
            fqdn                           = "app1.contoso.com"
            timeout_in_seconds             = 30
            evaluation_interval_in_seconds = 30
            unhealthy_treshold_count       = 3
            path                           = "/health"
            status_codes                   = ["200"]
          }
        }
      ]
    },
    {
      routing_rule = {
        priority = 2
      }
      listener = {
        fqdn             = "app2.contoso.com"
        protocol         = "https"
        certificate_name = "contoso-com"
      }
      backend = [
        {
          fqdns                         = ["app2.azurewebsites.net"]
          port                          = 443
          protocol                      = "https"
          cookie_based_affinity_enabled = false
          request_timeout_in_seconds    = 30
          health_probe = {
            fqdn                           = "app1.contoso.com"
            timeout_in_seconds             = 30
            evaluation_interval_in_seconds = 30
            unhealthy_treshold_count       = 3
            path                           = "/health"
            status_codes                   = ["200"]
          }
        }
      ]
    }
  ]
  redirect_listener_settings = [
    {
      routing_rule = {
        priority = 15000
      },
      listener = {
        fqdn     = "*.contoso.com"
        protocol = "http"
      },
      target = {
        listener_name        = "listener-https-app1-contoso-com"
        include_path         = true
        include_query_string = true
      }
    }
  ]
}
```

### Adding multiple SSL certificates

```hcl
module "application_gateway" {
  source              = "./azure/application_gateway"
  workload            = "your_workload"
  resource_group_name = "resource-group"
  naming_count        = "1"
  environment         = "dev"
  location            = "westeurope"
  min_instance_count  = "2"
  max_instance_count  = "10"
  waf_policy_settings = {
    "name"                = "waf-name",
    "resource_group_name" = "rg-waf-policy-resource-group"
  }
  network_settings = {
    vnet_name                = "virtual_network_name"
    vnet_resource_group_name = "rg-vnet-001"
    subnet_name              = "snet-appgateway-001"
  }
  managed_identity_settings = {
    name                = "my-managed-identity"
    resource_group_name = "rg-managed-identity"
  }
  ssl_certificates = [
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

<!-- END_TF_DOCS -->
