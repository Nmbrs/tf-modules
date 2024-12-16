locals {
  frontdoor_profile_name = lower("afd-${var.workload}-${var.environment}")
  # cache size translated into premium tier capacity
  sku_name = {
    Standard = "Standard_AzureFrontDoor"
    Premium  = "Premium_AzureFrontDoor"
  }
}
