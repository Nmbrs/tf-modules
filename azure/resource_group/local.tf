locals {
  default_tags = {
    ProvisionedBy = "Terraform"
    Country       = var.country
    Squad         = var.squad
    Product       = var.product
    Environment   = var.environment
  }

}
