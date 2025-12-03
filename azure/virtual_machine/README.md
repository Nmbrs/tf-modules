# Virtual Machine Module

## Summary

The `virtual_machine` module is a Terraform module that provides a convenient way to create virtual machines in Azure, both for Windows and Linux operating systems. The module includes all necessary configurations to provision and manage the virtual machine, including network interfaces, storage, and operating system. The module ensures compliance with specified policies and implements the Terraform code to provision virtual machines with ease, making it an ideal solution for those who want to streamline Nmbrs virtual machine infrastructure.

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5.0, < 2.0.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 3.117 |
| <a name="requirement_random"></a> [random](#requirement\_random) | ~> 3.7 |
| <a name="requirement_tls"></a> [tls](#requirement\_tls) | ~> 4.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | ~> 3.117 |
| <a name="provider_random"></a> [random](#provider\_random) | ~> 3.7 |
| <a name="provider_tls"></a> [tls](#provider\_tls) | ~> 4.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_linux_virtual_machine.linux_vm](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_virtual_machine) | resource |
| [azurerm_managed_disk.data_disks](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/managed_disk) | resource |
| [azurerm_network_interface.nic](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_interface) | resource |
| [azurerm_ssh_public_key.ssh_public_key](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/ssh_public_key) | resource |
| [azurerm_virtual_machine_data_disk_attachment.data_disks](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_machine_data_disk_attachment) | resource |
| [azurerm_windows_virtual_machine.windows_vm](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/windows_virtual_machine) | resource |
| [random_password.windows_vm](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [tls_private_key.ssh](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/resources/private_key) | resource |
| [azurerm_subnet.nic_subnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subnet) | data source |
| [azurerm_user_assigned_identity.vm](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/user_assigned_identity) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_admin_username"></a> [admin\_username](#input\_admin\_username) | (Optional) Specifies The administrator username for which the SSH Key or password should be configured. | `string` | `"automation"` | no |
| <a name="input_data_disks_settings"></a> [data\_disks\_settings](#input\_data\_disks\_settings) | A list of data disk objects, each containing information about a data disk to be attached to the deployment. Disk names are automatically generated based on sequence_number. | <pre>list(object({<br>    sequence_number      = number<br>    storage_account_type = string<br>    disk_size_gb         = number<br>    caching              = string<br>  }))</pre> | `[]` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | The environment in which the resource should be provisioned. Valid options: 'dev', 'test', 'prod', 'sand', 'stag'. | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | Specifies Azure location where the resources should be provisioned. For an exhaustive list of locations, please use the command 'az account list-locations -o table'. | `string` | n/a | yes |
| <a name="input_managed_identity_settings"></a> [managed\_identity\_settings](#input\_managed\_identity\_settings) | Settings related to the managed identity. If null, no managed identity will be assigned to the VM. | <pre>object({<br>    name                = string<br>    resource_group_name = string<br>  })</pre> | `null` | no |
| <a name="input_network_settings"></a> [network\_settings](#input\_network\_settings) | Settings related to the network connectivity of the virtual machine. | <pre>object({<br>    vnet_name                = string<br>    vnet_resource_group_name = string<br>    subnet_name              = string<br>  })</pre> | n/a | yes |
| <a name="input_os_disk_settings"></a> [os\_disk\_settings](#input\_os\_disk\_settings) | O.S. disk to be attached to the deployment. Disk name is automatically generated. | <pre>object({<br>    storage_account_type = string<br>    caching              = string<br>  })</pre> | n/a | yes |
| <a name="input_os_image_settings"></a> [os\_image\_settings](#input\_os\_image\_settings) | The operating system image for a virtual machine. | <pre>object({<br>    publisher = string<br>    offer     = string<br>    sku_name  = string<br>    version   = string<br>  })</pre> | n/a | yes |
| <a name="input_os_type"></a> [os\_type](#input\_os\_type) | Type of operating system to be installed on the virtual machine. Acceptable values are 'linux', 'windows'. | `string` | n/a | yes |
| <a name="input_override_name"></a> [override\_name](#input\_override\_name) | Optional override for naming logic. When provided, this exact name will be used for the VM. When null, the name will be automatically generated using workload, environment, and sequence_number. | `string` | `null` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of an existing Resource Group. | `string` | n/a | yes |
| <a name="input_sequence_number"></a> [sequence\_number](#input\_sequence\_number) | A numeric value used to ensure uniqueness for resource names. Only required when override_name is not provided. | `number` | `null` | no |
| <a name="input_sku_name"></a> [sku\_name](#input\_sku\_name) | The SKU which should be used for this Virtual Machine. For an exhaustive list of virtual machine sizes, please use the command 'az vm list-sizes --location your-location'. | `string` | `"Standard_DS2_v2"` | no |
| <a name="input_workload"></a> [workload](#input\_workload) | Short, descriptive name for the application, service, or workload. Used in resource naming conventions. Only required when override_name is not provided. | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_admin_password"></a> [admin\_password](#output\_admin\_password) | The password used for administrator-level access to the virtual machine, only applicable for Windows-based virtual machines. |
| <a name="output_admin_username"></a> [admin\_username](#output\_admin\_username) | The username used for administrator-level access to the virtual machine. |
| <a name="output_data_disks"></a> [data\_disks](#output\_data\_disks) | The details of the virtual machine's data disks. |
| <a name="output_name"></a> [name](#output\_name) | The virtual machine name. |
| <a name="output_network_interface"></a> [network\_interface](#output\_network\_interface) | The details of the virtual machine's network interface. |
| <a name="output_os_disk"></a> [os\_disk](#output\_os\_disk) | The details of the virtual machine's operating system disk. |
| <a name="output_os_image"></a> [os\_image](#output\_os\_image) | The details of the virtual machine's operating system image. |
| <a name="output_os_type"></a> [os\_type](#output\_os\_type) | The type of operating system to be installed on the virtual machine. Options are: windows, linux. |
| <a name="output_ssh_private_key"></a> [ssh\_private\_key](#output\_ssh\_private\_key) | The SSH private key of the virtual machine, used for secure access. |
| <a name="output_ssh_public_key"></a> [ssh\_public\_key](#output\_ssh\_public\_key) | The SSH public key of the virtual machine, used for secure access. |

## How to use it?

A number of code snippets demonstrating different use cases for the module have been included to help you understand how to use the module in Terraform.

## Windows Virtual Machine (using automatic naming)

```hcl
module "virtual_machine_windows" {
  source = "git::https://github.com/Nmbrs/tf-modules.git//azure/virtual_machine"

  workload            = "contoso"
  sequence_number     = 1
  environment         = "dev"
  location            = "westeurope"
  resource_group_name = "rg-virtual-machines"
  sku_name            = "Standard_D2s_v3"
  os_type             = "windows"

  os_image_settings = {
    source    = "marketplace"
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku_name  = "2016-Datacenter"
    version   = "latest"
  }

  os_disk_settings = {
    caching              = "ReadWrite"
    storage_account_type = "StandardSSD_LRS"
  }

  network_settings = {
    vnet_resource_group_name = "rg-network"
    vnet_name                = "vnet-dev-001"
    subnet_name              = "snet-dev-001"
  }
}
```

## Windows Virtual Machine (using custom naming)

```hcl
module "virtual_machine_windows" {
  source = "git::https://github.com/Nmbrs/tf-modules.git//azure/virtual_machine"

  override_name       = "vmwindows01"
  environment         = "dev"
  location            = "westeurope"
  resource_group_name = "rg-virtual-machines"
  sku_name            = "Standard_D2s_v3"
  os_type             = "windows"

  os_image_settings = {
    source    = "marketplace"
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku_name  = "2016-Datacenter"
    version   = "latest"
  }

  os_disk_settings = {
    caching              = "ReadWrite"
    storage_account_type = "StandardSSD_LRS"
  }

  network_settings = {
    vnet_resource_group_name = "rg-network"
    vnet_name                = "vnet-dev-001"
    subnet_name              = "snet-dev-001"
  }
}
```

## Linux Virtual Machine

```hcl
module "virtual_machine_linux" {
  source = "git::https://github.com/Nmbrs/tf-modules.git//azure/virtual_machine"

  workload            = "linux"
  sequence_number     = 1
  environment         = "dev"
  location            = "westeurope"
  resource_group_name = "rg-virtual-machines"
  sku_name            = "Standard_D2s_v3"
  os_type             = "linux"

  os_image_settings = {
    source    = "marketplace"
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku_name  = "22_04-lts-gen2"
    version   = "latest"
  }

  os_disk_settings = {
    caching              = "ReadWrite"
    storage_account_type = "StandardSSD_LRS"
  }

  network_settings = {
    vnet_resource_group_name = "rg-network"
    vnet_name                = "vnet-dev-001"
    subnet_name              = "snet-dev-001"
  }
}
```

## Attach Data Disks to VM

```hcl
module "virtual_machine_linux" {
  source = "git::https://github.com/Nmbrs/tf-modules.git//azure/virtual_machine"

  workload            = "linux"
  sequence_number     = 2
  environment         = "dev"
  location            = "westeurope"
  resource_group_name = "rg-virtual-machines"
  sku_name            = "Standard_D2s_v3"
  os_type             = "linux"

  os_image_settings = {
    source    = "marketplace"
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku_name  = "22_04-lts-gen2"
    version   = "latest"
  }

  os_disk_settings = {
    caching              = "ReadWrite"
    storage_account_type = "StandardSSD_LRS"
  }

  # Data disks configuration
  # Note: Disk names are automatically generated based on sequence_number
  # Format: dsk-{vm_name}-data-{sequence_number}
  data_disks_settings = [
    {
      sequence_number      = 1
      caching              = "None"
      disk_size_gb         = 10
      storage_account_type = "StandardSSD_LRS"
    },
    {
      sequence_number      = 2
      caching              = "None"
      disk_size_gb         = 20
      storage_account_type = "StandardSSD_LRS"
    }
  ]

  network_settings = {
    vnet_resource_group_name = "rg-network"
    vnet_name                = "vnet-dev-001"
    subnet_name              = "snet-dev-001"
  }
}
```

## Virtual Machine with Managed Identity

```hcl
module "virtual_machine_linux" {
  source = "git::https://github.com/Nmbrs/tf-modules.git//azure/virtual_machine"

  workload            = "linux"
  sequence_number     = 3
  environment         = "dev"
  location            = "westeurope"
  resource_group_name = "rg-virtual-machines"
  sku_name            = "Standard_D2s_v3"
  os_type             = "linux"

  os_image_settings = {
    source    = "marketplace"
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku_name  = "22_04-lts-gen2"
    version   = "latest"
  }

  os_disk_settings = {
    caching              = "ReadWrite"
    storage_account_type = "StandardSSD_LRS"
  }

  network_settings = {
    vnet_resource_group_name = "rg-network"
    vnet_name                = "vnet-dev-001"
    subnet_name              = "snet-dev-001"
  }

  # Optional: Assign a managed identity to the VM
  managed_identity_settings = {
    name                = "mi-vm-identity"
    resource_group_name = "rg-identity"
  }
}
```

## Linux VM from Shared Image Gallery

```hcl
module "virtual_machine_linux_gallery" {
  source = "git::https://github.com/Nmbrs/tf-modules.git//azure/virtual_machine"

  workload            = "webapp"
  sequence_number     = 1
  environment         = "prod"
  location            = "westeurope"
  resource_group_name = "rg-virtual-machines"
  sku_name            = "Standard_D2s_v3"
  os_type             = "linux"

  # Use custom image from Shared Image Gallery
  os_image_settings = {
    source                      = "shared_gallery"
    gallery_name                = "myimagegallery"
    gallery_resource_group_name = "rg-images"
    image_name                  = "ubuntu-22-04-hardened"
    image_version               = "1.0.0"
  }

  os_disk_settings = {
    caching              = "ReadWrite"
    storage_account_type = "Premium_LRS"
  }

  network_settings = {
    vnet_resource_group_name = "rg-network"
    vnet_name                = "vnet-prod-001"
    subnet_name              = "snet-prod-001"
  }
}
```

## Windows VM from Shared Image Gallery

```hcl
module "virtual_machine_windows_gallery" {
  source = "git::https://github.com/Nmbrs/tf-modules.git//azure/virtual_machine"

  override_name       = "vmwinapp01"
  environment         = "prod"
  location            = "westeurope"
  resource_group_name = "rg-virtual-machines"
  sku_name            = "Standard_D4s_v3"
  os_type             = "windows"

  # Use custom Windows image from Shared Image Gallery
  os_image_settings = {
    source                      = "shared_gallery"
    gallery_name                = "myimagegallery"
    gallery_resource_group_name = "rg-images"
    image_name                  = "windows-server-2022-hardened"
    image_version               = "2.1.0"
  }

  os_disk_settings = {
    caching              = "ReadWrite"
    storage_account_type = "Premium_LRS"
  }

  network_settings = {
    vnet_resource_group_name = "rg-network"
    vnet_name                = "vnet-prod-001"
    subnet_name              = "snet-prod-001"
  }

  # Optional: Assign managed identity for accessing Azure resources
  managed_identity_settings = {
    name                = "mi-vm-prod"
    resource_group_name = "rg-identity"
  }
}
```

## Important Notes

### Image Source Options

The module supports two image sources via the `os_image_settings.source` field:

1. **Marketplace Images** (`source = "marketplace"`):
   - Use Azure Marketplace images from Microsoft, Canonical, RedHat, etc.
   - Required fields: `publisher`, `offer`, `sku_name`, `version`
   - Example: Ubuntu 22.04, Windows Server 2022, etc.
   - Use `version = "latest"` to always get the latest image version

2. **Shared Image Gallery** (`source = "shared_gallery"`):
   - Use custom images from your Azure Shared Image Gallery
   - Required fields: `gallery_name`, `gallery_resource_group_name`, `image_name`, `image_version`
   - Use this for:
     - Custom hardened or pre-configured OS images
     - Golden images with pre-installed software
     - Compliance-approved base images
     - Company-standard VM templates

**Note**: The two image sources are completely decoupled. Simply set the `source` field and provide the appropriate fields for your chosen source. The module handles the rest automatically.

### Naming Convention

The module supports two naming approaches:

1. **Automatic naming** (recommended): Provide `workload`, `sequence_number`, and `environment`
   - Format: `vm{workload}{environment}{sequence_number}`
   - Example: `vmcontosodemo001`

2. **Custom naming**: Provide `override_name`
   - Uses your exact name
   - Example: `vmwindows01`

### Resource Name Generation

The following resources are automatically named by the module:

- VM name: Based on naming convention above
- OS disk: `dsk-{vm_name}-os-001`
- Data disks: `dsk-{vm_name}-data-{sequence_number}`
- Network interface: `nic-{vm_name}`
- SSH public key: `sshkey-{vm_name}` (Linux only)

### Windows VM Limitations

- VM name must be 15 characters or less due to NETBIOS limitations
- The module validates this at plan time

### Authentication

- **Linux VMs**: Use SSH key-based authentication (passwordless)
  - SSH keys are automatically generated by the module
  - Private key is available as a sensitive output
- **Windows VMs**: Use randomly generated 32-character passwords
  - Password is available as a sensitive output
