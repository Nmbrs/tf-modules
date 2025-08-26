locals {
  # Document which branches exist with different cases
  branch_variations = {
    main         = ["main", "Main"]
    master       = ["master", "Master"] 
    dev          = ["dev", "Dev"]
    development  = ["development", "Development"]
    prod         = ["prod", "Prod"]
    production   = ["production", "Production"]
    instant      = ["instant", "Instant"]
    test         = ["test", "Test"]
    kitchen      = ["kitchen"]
  }
  
  # Flatten the variations into a single list
  branches = flatten(values(local.branch_variations))
  
  protect_branch_list = concat(
    ["~DEFAULT_BRANCH"],
    [for branch in local.branches : "refs/heads/${branch}"]
  )
}
