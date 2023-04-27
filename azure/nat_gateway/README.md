# Virtual Machine Module

## Summary

The NAT Gateway module is a Terraform module that provides a convenient way to create NAT gateways in Azure.
The module includes all necessary configurations to provision and manage the NAT gateway, including vnet, subnet, and SKU. The module ensures compliance with specified policies and implements the Terraform code to provision NAT gateway with ease, making it an ideal solution for those who want to streamline Nmbrs network infrastructure.

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.0, < 2.0.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 3.6 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | ~> 3.6 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_subnet.vnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet) | resource |
| [azurerm_public_ip.natgw](https://registry.terraform.io/providers/hashicorp/azurerm/2.83.0/docs/resources/public_ip) | resource |
| [azurerm_network_interface.nics](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_interface) | resource |
| [azurerm_nat_gateway.natgw](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/nat_gateway) | resource |
| [azurerm_nat_gateway_public_ip_association.natgw](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/nat_gateway_public_ip_association) | resource |
| [azurerm_subnet_nat_gateway_association.natgw](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet_nat_gateway_association)

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="name"></a> [name](#input\_name) | (Optional) Specifies the name for the NAT gateway. | `string` | `"automation"` | no |
| <a name="subnets"></a> [subnets](#input\_subnets) | A list of subnets to be added to the app gw. | <pre>map(object({<br>    name                 = string<br>    virtual_network_name = string<br>    resource_group_name         = string<br>    }))</pre> | `[]` | no |
| <a name="environment"></a> [environment](#input\_environment) | The environment in which the resource should be provisioned. | `string` | n/a | yes |
| <a name="natgw_resource_group"></a> [natgw\_resource\_group](#input\_natgw\_resource\_group) | Where the NAT gateway should be provisioned. | <pre>list(object({<br>    name                     = string<br>    vnet_resource_group_name = string<br>    vnet_name                = string<br>    subnet_name              = string<br>  }))</pre> | `[]` | no |
| <a name="input_os_disk"></a> [os\_disk](#input\_os\_disk) | O.S. disk to be attached to the deployment. | <pre>object({<br>    name                 = string<br>    storage_account_type = string<br>    caching              = string<br>  })</pre> | n/a | yes |
| <a name="input_os_image"></a> [os\_image](#input\_os\_image) | The operating system image for a virtual machine. | <pre>object({<br>    publisher = string<br>    offer     = string<br>    sku       = string<br>    version   = string<br>  })</pre> | n/a | yes |
| <a name="input_os_type"></a> [os\_type](#input\_os\_type) | Type of virtual machine to be created. Acceptable values are 'dev', 'test', 'prod' or 'sand'. | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of an existing Resource Group. | `string` | n/a | yes |
| <a name="input_vm_name"></a> [vm\_name](#input\_vm\_name) | The name of the virtual machine. | `string` | n/a | yes |
| <a name="input_vm_size"></a> [vm\_size](#input\_vm\_size) | The SKU which should be used for this Virtual Machine. For an exaustive list of virtual, please use the command 'az vm list-sizes --location 'your-location''. | `string` | `"Standard_D2s_v3"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="public_ip_address"></a> [public\_ip](#output\_public\_ip) | The public ip used by the NAT gateway. |

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