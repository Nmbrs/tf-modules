resource "azuread_user" "user" {

  user_principal_name = format(
    "%s.%s@%s",
    trimspace(lower(var.first_name)),
    trimspace(lower(var.last_name)),
    lower(var.domain_name)
  )

  password = format(
    "%s%s%s!",
    substr(lower(var.first_name), 0, 1),
    trimspace(lower(var.last_name)),
    length(var.first_name)
  )
  force_password_change       = true
  disable_password_expiration = false
  disable_strong_password     = false


  display_name = "${var.first_name} ${var.last_name}"
  department   = var.department
}
