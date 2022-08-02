locals {
  default_tags = {
    environment = var.environment
    managed_by  = "terraform"
    status      = var.status
  }
}
