locals {
  vm_name = (var.override_name != null ?
    lower(var.override_name) :
    lower("vm${var.workload}${var.environment}${format("%03d", var.sequence_number)}")
  )

  ssh_public_key_name = lower("sshkey-${local.vm_name}")

  nic_name = lower("nic-${local.vm_name}")

  os_disk_name = lower("dsk-${local.vm_name}-os-001")

  data_disk_name_prefix = lower("dsk-${local.vm_name}-data")

}
