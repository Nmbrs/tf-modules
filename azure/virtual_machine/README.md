# Virtual Machine Module

## Summary

The virtual machine module is a Terraform module that provides a convenient way to create virtual machines in Azure, both for Windows and Linux operating systems. The module includes all necessary configurations to provision and manage the virtual machine, including network interfaces, storage, and operating system. The module ensures compliance with specified policies and implements the Terraform code to provision virtual machines with ease, making it an ideal solution for those who want to streamline Nmbrs virtual machine infrastructure.

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.0, < 2.0.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 3.6 |
| <a name="requirement_random"></a> [random](#requirement\_random) | ~> 3.2.0 |
| <a name="requirement_tls"></a> [tls](#requirement\_tls) | ~> 4.0.4 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | ~> 3.6 |
| <a name="provider_random"></a> [random](#provider\_random) | ~> 3.2.0 |
| <a name="provider_tls"></a> [tls](#provider\_tls) | ~> 4.0.4 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_linux_virtual_machine.linux_vm](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_virtual_machine) | resource |
| [azurerm_managed_disk.data_disks](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/managed_disk) | resource |
| [azurerm_network_interface.nics](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_interface) | resource |
| [azurerm_ssh_public_key.ssh_public_key](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/ssh_public_key) | resource |
| [azurerm_virtual_machine_data_disk_attachment.data_disks](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_machine_data_disk_attachment) | resource |
| [azurerm_windows_virtual_machine.windows_vm](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/windows_virtual_machine) | resource |
| [random_password.password](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [tls_private_key.ssh](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/resources/private_key) | resource |
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/client_config) | data source |
| [azurerm_resource_group.vm_rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |
| [azurerm_subnet.nic_subnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subnet) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_admin_username"></a> [admin\_username](#input\_admin\_username) | (Optional) Specifies The administrator username for which the SSH Key or password should be configured. | `string` | `"automation"` | no |
| <a name="input_data_disks"></a> [data\_disks](#input\_data\_disks) | A list of data disk objects, each containing information about a data disk to be attached to the deployment. | <pre>list(object({<br>    name                 = string<br>    storage_account_type = string<br>    disk_size_gb         = number<br>    caching              = string<br>  }))</pre> | `[]` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | The environment in which the resource should be provisioned. | `string` | n/a | yes |
| <a name="input_network_interfaces"></a> [network\_interfaces](#input\_network\_interfaces) | A list of network interface objects, each containing information about a network interface to be created in the deployment. | <pre>list(object({<br>    name                     = string<br>    vnet_resource_group_name = string<br>    vnet_name                = string<br>    subnet_name              = string<br>  }))</pre> | `[]` | no |
| <a name="input_os_disk"></a> [os\_disk](#input\_os\_disk) | O.S. disk to be attached to the deployment. | <pre>object({<br>    name                 = string<br>    storage_account_type = string<br>    caching              = string<br>  })</pre> | n/a | yes |
| <a name="input_os_image"></a> [os\_image](#input\_os\_image) | The operating system image for a virtual machine. | <pre>object({<br>    publisher = string<br>    offer     = string<br>    sku       = string<br>    version   = string<br>  })</pre> | n/a | yes |
| <a name="input_os_type"></a> [os\_type](#input\_os\_type) | Type of virtual machine to be created. Acceptable values are 'dev', 'test', 'prod' or 'sand'. | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of an existing Resource Group. | `string` | n/a | yes |
| <a name="input_vm_name"></a> [vm\_name](#input\_vm\_name) | The name of the virtual machine. | `string` | n/a | yes |
| <a name="input_vm_size"></a> [vm\_size](#input\_vm\_size) | The SKU which should be used for this Virtual Machine. For an exaustive list of virtual, please use the command 'az vm list-sizes --location 'your-location''. | `string` | `"Standard_D2s_v3"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_admin_password"></a> [admin\_password](#output\_admin\_password) | The password used for administrator-level access to the virtual machine, only applicable for Windows-based virtual machines. |
| <a name="output_admin_username"></a> [admin\_username](#output\_admin\_username) | The username used for administrator-level access to the virtual machine. |
| <a name="output_data_disk"></a> [data\_disk](#output\_data\_disk) | The details of the virtual machine's data disks. |
| <a name="output_name"></a> [name](#output\_name) | The virtual machine name. |
| <a name="output_network_interfaces"></a> [network\_interfaces](#output\_network\_interfaces) | The details of the virtual machine's network interfaces. |
| <a name="output_os_disk"></a> [os\_disk](#output\_os\_disk) | The details of the virtual machine's operating system disk. |
| <a name="output_os_image"></a> [os\_image](#output\_os\_image) | The details of the virtual machine's operating system  image |
| <a name="output_os_type"></a> [os\_type](#output\_os\_type) | The type of operating system to be installed on the virtual machine. Options are: windows, linux. |
| <a name="output_ssh_private_key"></a> [ssh\_private\_key](#output\_ssh\_private\_key) | The SSH private key of the virtual machine, used for secure access. |
| <a name="output_ssh_public_key"></a> [ssh\_public\_key](#output\_ssh\_public\_key) | The SSH public key of the virtual machine, used for secure access. |

## How to use it?

A number of code snippets demonstrating different use cases for the module have been included to help you understand how to use the module in Terraform.

## Windows Virtual Machine

```hcl
module "virtual_machine_windows" {
  source = "git::github.com/Nmbrs/tf-modules//azure/virtual_machine"

  vm_name             = "vmwindows01"
  environment         = "dev"
  resource_group_name = "rg-virtual-machines"
  vm_size             = "Standard_D2s_v3"
  os_type             = "windows"
  os_image = {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2016-Datacenter"
    version   = "latest"
  }

  os_disk = {
    name                 = "dsk-vmwindows01-os-001"
    caching              = "ReadWrite"
    storage_account_type = "StandardSSD_LRS"
  }
}

  network_interfaces = [
    {
      name                     = "nic-vmwindows01-001",
      resource_group_name      = "rg-virtual-machines"
      vnet_name                = "vnet-dev-001"
      subnet_name              = "snet-dev-001"
    }
  ]
```

## Linux Virtual Machine

```hcl
module "virtual_machine_linux" {
  source = "git::github.com/Nmbrs/tf-modules//azure/virtual_machine"

  vm_name             = "vmlinux01"
  environment         = "dev"
  resource_group_name = "rg-virtual-machines"
  vm_size             = "Standard_D2s_v3"
  os_type             = "linux"
  os_image = {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  }

  os_disk = {
    name                 = "dsk-vmlinux01-os-001"
    caching              = "ReadWrite"
    storage_account_type = "StandardSSD_LRS"
  }

  network_interfaces = [
    {
      name                     = "nic-vmlinux01-001",
      resource_group_name      = "rg-virtual-machines"
      vnet_name                = "vnet-dev-001"
      subnet_name              = "snet-dev-001"
    }
  ]
}
```

## Attach Data Disks to VM

```hcl
module "virtual_machine_linux" {
  source = "git::github.com/Nmbrs/tf-modules//azure/virtual_machine"

  vm_name             = "vmlinux02"
  environment         = "dev"
  resource_group_name = "rg-virtual-machines"
  vm_size             = "Standard_D2s_v3"
  os_type             = "linux"
  os_image = {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  }

  os_disk = {
    name                 = "dsk-vmlinux02-os-001"
    caching              = "ReadWrite"
    storage_account_type = "StandardSSD_LRS"
  }

  data_disks = [{
    caching              = "None"
    disk_size_gb         = 10
    name                 = "dsk-vmlinux02-data-001"
    storage_account_type = "StandardSSD_LRS"
  }]

  network_interfaces = [
    {
      name                     = "nic-vmlinux02-001",
      resource_group_name      = "rg-virtual-machines"
      vnet_name                = "vnet-dev-001"
      subnet_name              = "snet-dev-001"
    }
  ]
}
```

## Include multiple Network interfaces

```hcl
module "virtual_machine_linux" {
  source = "git::github.com/Nmbrs/tf-modules//azure/virtual_machine"

  vm_name             = "vmlinux03"
  environment         = "dev"
  resource_group_name = "rg-virtual-machines"
  vm_size             = "Standard_D2s_v3"
  os_type             = "linux"
  os_image = {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  }

  os_disk = {
    name                 = "dsk-vmlinux03-os-001"
    caching              = "ReadWrite"
    storage_account_type = "StandardSSD_LRS"
  }

  network_interfaces = [
    {
      name                     = "nic-vmlinux03-001",
      resource_group_name      = "rg-virtual-machines"
      vnet_name                = "vnet-dev-001"
      subnet_name              = "snet-dev-001"
    },
    {
      name                     = "nic-vmlinux03-002",
      resource_group_name      = "rg-virtual-machines"
      vnet_name                = "vnet-dev-001"
      subnet_name              = "snet-dev-002"
    }
  ]
}
```