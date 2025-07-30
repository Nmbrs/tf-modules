locals {
  # Redis Cache naming following standard conventions
  # Format: redis-{company}-{workload}-{env}-{location}-{seq}
  redis_cache_name = (var.override_name != null ?
    lower(var.override_name) :
    lower("redis-${var.company_prefix}-${var.workload}-${var.environment}-${var.location}-${format("%03d", var.sequence_number)}")
  )
}

locals {
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
