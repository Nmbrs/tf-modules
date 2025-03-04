resource "azapi_resource" "app_service_domain" {
  type      = "Microsoft.DomainRegistration/domains@2024-04-01"
  name      = var.name
  location  = "global"
  parent_id = data.azurerm_resource_group.app_service_domain.id
  body = {
    properties = {
      consent = {
        agreedAt = timestamp()
        agreedBy = var.contact.organization
        agreementKeys = [
          "DNRA",
          "DNPA"
        ]
      }
      contactAdmin = {
        addressMailing = {
          address1   = var.contact.address_line_1
          address2   = var.contact.address_line_2
          city       = var.contact.city
          country    = var.contact.country_code
          postalCode = var.contact.postal_code
          state      = var.contact.state
        }
        email        = var.contact.email
        fax          = var.contact.fax
        jobTitle     = var.contact.job_title
        nameFirst    = var.contact.name_first
        nameLast     = var.contact.name_last
        nameMiddle   = var.contact.name_middle
        organization = var.contact.organization
        phone        = var.contact.phone
      }
      contactBilling = {
        addressMailing = {
          address1   = var.contact.address_line_1
          address2   = var.contact.address_line_2
          city       = var.contact.city
          country    = var.contact.country_code
          postalCode = var.contact.postal_code
          state      = var.contact.state
        }
        email        = var.contact.email
        fax          = var.contact.fax
        jobTitle     = var.contact.job_title
        nameFirst    = var.contact.name_first
        nameLast     = var.contact.name_last
        nameMiddle   = var.contact.name_middle
        organization = var.contact.organization
        phone        = var.contact.phone
      }
      contactRegistrant = {
        addressMailing = {
          address1   = var.contact.address_line_1
          address2   = var.contact.address_line_2
          city       = var.contact.city
          country    = var.contact.country_code
          postalCode = var.contact.postal_code
          state      = var.contact.state
        }
        email        = var.contact.email
        fax          = var.contact.fax
        jobTitle     = var.contact.job_title
        nameFirst    = var.contact.name_first
        nameLast     = var.contact.name_last
        nameMiddle   = var.contact.name_middle
        organization = var.contact.organization
        phone        = var.contact.phone
      }
      contactTech = {
        addressMailing = {
          address1   = var.contact.address_line_1
          address2   = var.contact.address_line_2
          city       = var.contact.city
          country    = var.contact.country_code
          postalCode = var.contact.postal_code
          state      = var.contact.state
        }
        email        = var.contact.email
        fax          = var.contact.fax
        jobTitle     = var.contact.job_title
        nameFirst    = var.contact.name_first
        nameLast     = var.contact.name_last
        nameMiddle   = var.contact.name_middle
        organization = var.contact.organization
        phone        = var.contact.phone
      }
      dnsZoneId     = data.azurerm_dns_zone.app_service_domain.id
      privacy       = true
      autoRenew     = true
      targetDnsType = "AzureDns",
    }
  }
  lifecycle {
    ignore_changes = [
      tags, body
    ]
  }
}