
"$schema": "https://schema.management.azure.com/schemas/2019-04-01/deploymentTemplate.json",
"contentVersion": "1.0.0.0",
"parameters": {
    "subscriptionId": {
        "type": "string"
    },
    "domainName": {
        "type": "string"
    },
    "resourceGroup": {
        "type": "string"
    },
    "agreementKeys": {
        "type": "array"
    },
    "AgreedBy": {
        "type": "string"
    },
    "AgreedAt": {
        "type": "string"
    },
    "Address1": {
        "type": "string"
    },
    "Address2": {
        "type": "string"
    },
    "City": {
        "type": "string"
    },
    "Country": {
        "type": "string"
    },
    "PostalCode": {
        "type": "string"
    },
    "State": {
        "type": "string"
    },
    "Email": {
        "type": "string"
    },
    "JobTitle": {
        "type": "string"
    },
    "NameFirst": {
        "type": "string"
    },
    "NameLast": {
        "type": "string"
    },
    "NameMiddle": {
        "type": "string"
    },
    "Organization": {
        "type": "string"
    },
    "Phone": {
        "type": "string"
    },
    "autoRenew": {
        "type": "bool"
    },
    "privacy": {
        "type": "bool"
    }
},
"resources": [
    {
        "apiVersion": "2022-03-01",
        "name": "[parameters('domainName')]",
        "type": "Microsoft.DomainRegistration/domains",
        "location": "global",
        "tags": {},
        "dependsOn": [
            "Microsoft.Network/dnszones/nmbrswhitelabel-dev.com"
        ],
        "properties": {
            "Consent": {
                "AgreementKeys": "[parameters('agreementKeys')]",
                "AgreedBy": "[parameters('AgreedBy')]",
                "AgreedAt": "[parameters('AgreedAt')]"
            },
            "ContactAdmin": {
                "AddressMailing": {
                    "Address1": "[parameters('Address1')]",
                    "Address2": "[parameters('Address2')]",
                    "City": "[parameters('City')]",
                    "Country": "[parameters('Country')]",
                    "PostalCode": "[parameters('PostalCode')]",
                    "State": "[parameters('State')]"
                },
                "Email": "[parameters('Email')]",
                "Fax": "",
                "JobTitle": "[parameters('JobTitle')]",
                "NameFirst": "[parameters('NameFirst')]",
                "NameLast": "[parameters('NameLast')]",
                "NameMiddle": "[parameters('NameMiddle')]",
                "Organization": "[parameters('Organization')]",
                "Phone": "[parameters('Phone')]"
            },
            "ContactBilling": {
                "AddressMailing": {
                    "Address1": "[parameters('Address1')]",
                    "Address2": "[parameters('Address2')]",
                    "City": "[parameters('City')]",
                    "Country": "[parameters('Country')]",
                    "PostalCode": "[parameters('PostalCode')]",
                    "State": "[parameters('State')]"
                },
                "Email": "[parameters('Email')]",
                "Fax": "",
                "JobTitle": "[parameters('JobTitle')]",
                "NameFirst": "[parameters('NameFirst')]",
                "NameLast": "[parameters('NameLast')]",
                "NameMiddle": "[parameters('NameMiddle')]",
                "Organization": "[parameters('Organization')]",
                "Phone": "[parameters('Phone')]"
            },
            "ContactRegistrant": {
                "AddressMailing": {
                    "Address1": "[parameters('Address1')]",
                    "Address2": "[parameters('Address2')]",
                    "City": "[parameters('City')]",
                    "Country": "[parameters('Country')]",
                    "PostalCode": "[parameters('PostalCode')]",
                    "State": "[parameters('State')]"
                },
                "Email": "[parameters('Email')]",
                "Fax": "",
                "JobTitle": "[parameters('JobTitle')]",
                "NameFirst": "[parameters('NameFirst')]",
                "NameLast": "[parameters('NameLast')]",
                "NameMiddle": "[parameters('NameMiddle')]",
                "Organization": "[parameters('Organization')]",
                "Phone": "[parameters('Phone')]"
            },
            "ContactTech": {
                "AddressMailing": {
                    "Address1": "[parameters('Address1')]",
                    "Address2": "[parameters('Address2')]",
                    "City": "[parameters('City')]",
                    "Country": "[parameters('Country')]",
                    "PostalCode": "[parameters('PostalCode')]",
                    "State": "[parameters('State')]"
                },
                "Email": "[parameters('Email')]",
                "Fax": "",
                "JobTitle": "[parameters('JobTitle')]",
                "NameFirst": "[parameters('NameFirst')]",
                "NameLast": "[parameters('NameLast')]",
                "NameMiddle": "[parameters('NameMiddle')]",
                "Organization": "[parameters('Organization')]",
                "Phone": "[parameters('Phone')]"
            },
            "privacy": "[parameters('privacy')]",
            "autoRenew": "[parameters('autoRenew')]",
            "targetDnsType": "AzureDns",
            "dnsZoneId": "[concat('/subscriptions/', parameters('subscriptionId'),'/resourcegroups/', parameters('resourceGroup'), '/providers/Microsoft.Network/dnszones/', parameters('domainName'))]"
        }
    },
    {
        "type": "Microsoft.DomainRegistration/domains/providers/locks",
        "name": "nmbrswhitelabel-dev.com/Microsoft.Authorization/nmbrswhitelabel-dev.com",
        "apiVersion": "2017-04-01",
        "dependsOn": [
            "Microsoft.DomainRegistration/domains/nmbrswhitelabel-dev.com"
        ],
        "properties": {
            "level": "CannotDelete",
            "notes": "Deleting a domain will make it unavailable to purchase for 60 days. Please remove the lock before deleting this domain."
        }
    },
    {
        "type": "Microsoft.Network/dnszones",
        "name": "nmbrswhitelabel-dev.com",
        "apiVersion": "2018-05-01",
        "location": "global",
        "properties": {}
    },
    {
        "type": "Microsoft.Network/dnszones/providers/locks",
        "name": "nmbrswhitelabel-dev.com/Microsoft.Authorization/nmbrswhitelabel-dev.com",
        "apiVersion": "2017-04-01",
        "dependsOn": [
            "Microsoft.Network/dnszones/nmbrswhitelabel-dev.com"
        ],
        "properties": {
            "level": "CannotDelete",
            "notes": "This DNS zone was created when purchasing a domain and is likely still required by the domain. If you still want to delete this DNS zone please remove the lock and delete the zone."
        }
    }
]
}