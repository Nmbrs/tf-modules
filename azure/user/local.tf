locals {
  domain_name = data.azuread_domains.aad_domains.domains.0.domain_name
}