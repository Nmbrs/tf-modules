locals {
  cache_size_gb = var.cache_size_gb

  # cache size translated into premium tier capacity
  premium_tier_capacity = {
    6   = 1
    13  = 2
    26  = 3
    53  = 4
    120 = 5
  }
}
