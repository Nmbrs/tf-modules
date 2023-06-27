locals {
  # cache size translated into premium tier capacity
  premium_tier_capacity = {
    6   = 1
    13  = 2
    26  = 3
    53  = 4
    120 = 5
  }
}
