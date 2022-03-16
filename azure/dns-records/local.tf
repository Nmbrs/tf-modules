locals {
  auto_tags = {
    ManagedBy : "Terraform"
  }
  # cname_record = [
  #   for key, cname in var.cname : 
  #   cname.record if ! contains([""], cname.record)
  # ]
  # cname_record = {
  #   for_each = var.a
  #   record = [for key, cname in var.cname :
  #     cname.record if !contains([""], cname.record)
  #   ]
  # }
}

