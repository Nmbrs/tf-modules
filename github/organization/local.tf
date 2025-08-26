locals {
  protect_branch_list = [
    "~DEFAULT_BRANCH",
    "refs/heads/dev",
    "refs/heads/Dev",
    "refs/heads/development",
    "refs/heads/Development",
    "refs/heads/prod",
    "refs/heads/Prod",
    "refs/heads/production",
    "refs/heads/Production",
    "refs/heads/instant",
    "refs/heads/Instant",
    "refs/heads/test",
    "refs/heads/Test",
    "refs/heads/main",
    "refs/heads/Main",
    "refs/heads/master",
    "refs/heads/Master",
    "refs/heads/kitchen"
  ]
}
