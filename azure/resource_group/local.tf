locals {
  default_tags = {
    environment = var.environment
    managed_by  = "terraform"
    status      = var.status
    category    = var.category
    owner       = var.owner
    product     = var.product
    country     = var.country
  }
}
