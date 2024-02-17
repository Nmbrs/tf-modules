locals {
  redis_cache_name = lower("redis-${var.workload}-${var.environment}")
  # cache size translated into premium tier capacity
  premium_tier_capacity = {
    6   = 1
    13  = 2
    26  = 3
    53  = 4
    120 = 5
  }
  basic_standard_tier_capacity = {
    0.25 = 0
    1    = 1
    2.5  = 2
    6    = 3
    13   = 4
    26   = 5
    53   = 6
  }
}
