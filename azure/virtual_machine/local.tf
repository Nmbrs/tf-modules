locals {
  default_tags = {
    ProvisionedBy = "Terraform"
  }

  os_type = contains(
    [
      "windows server 2016",
      "windows server 2019",
      "windows server 2022",
      "sql server 2017",
      "sql server 2019",
      "sql server 2022"
    ], lower(var.os_type)
  ) ? "windows" : "linux"

  os_image = {
    "ubuntu 22.04 lts" = {
      publisher = "Canonical"
      offer     = "0001-com-ubuntu-server-jammy"
      sku       = "22_04-lts-gen2"
      version   = "latest"
    },
    "ubuntu 20.04 lts" = {
      publisher = "Canonical"
      offer     = "0001-com-ubuntu-server-focal"
      sku       = "20_04-lts-gen2"
      version   = "latest"
    },
    "ubuntu 18.04 lts" = {
      publisher = "Canonical"
      offer     = "UbuntuServer"
      sku       = "18_04-lts-gen2"
      version   = "latest"
    },
    "debian 11" = {
      publisher = "Debian"
      offer     = "debian-11"
      sku       = "11-gen2"
      version   = "latest"
    },
    "debian 10" = {
      publisher = "Debian"
      offer     = "debian-10"
      sku       = "10-gen2"
      version   = "latest"
    },
    "windows server 2016" = {
      publisher = "MicrosoftWindowsServer"
      offer     = "WindowsServer"
      sku       = "2016-datacenter-gensecond"
      version   = "latest"
    },
    "windows server 2019" = {
      publisher = "MicrosoftWindowsServer"
      offer     = "WindowsServer"
      sku       = "2019-datacenter-gensecond"
      version   = "latest"
    },
    "windows server 2022" = {
      publisher = "MicrosoftWindowsServer"
      offer     = "WindowsServer"
      sku       = "2022-datacenter-g2"
      version   = "latest"
    }
    "sql server 2016" = {
      publisher = "MicrosoftSQLServer"
      offer     = "sql2017-ws2019"
      sku       = "sqldev-gen2"
      version   = "latest"
    },
    "sql server 2019" = {
      publisher = "MicrosoftSQLServer"
      offer     = "sql2019-ws2022"
      sku       = "sqldev-gen2"
      version   = "latest"
    },
    "sql server 2022" = {
      publisher = "MicrosoftSQLServer"
      offer     = "sql2022-ws2022"
      sku       = "sqldev-gen2"
      version   = "latest"
    }


  }
}
