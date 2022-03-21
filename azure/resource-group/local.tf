locals {
  enforced_tags = {
    ManagedBy   = "Terraform"
    Country     = var.country
    Squad       = var.squad
    Product     = var.product
    Environment = var.environment
  }

}
