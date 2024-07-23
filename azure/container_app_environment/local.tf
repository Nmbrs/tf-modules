locals {
#container_app_environment_name = lower("cae-${var.workload}-${var.environment}-${var.location}-${format("%03d", var.naming_count)}")
container_app_environment_name = lower("cae-${var.workload}-${format("%03d", var.naming_count)}-${var.environment}")
#container_app_environment_name = lower("cae-${var.workload}-${var.environment}")
# certificate_request_body =
#         {
#             "type": "Microsoft.App/managedEnvironments/certificates",
#             "apiVersion": "2024-03-01",
#             "name": "[concat(parameters('managedEnvironments_cae_monitoring_001_dev_name'), '/wildcard-nmbrsapp-dev-com')]",
#             "location": "westeurope",
#             "dependsOn": [
#                 "[resourceId('Microsoft.App/managedEnvironments', parameters('managedEnvironments_cae_monitoring_001_dev_name'))]"
#             ],
#             "tags": {
#                 "created_at": "2024-04-18T08:27:11.0358309Z",
#                 "category": "not_applicable",
#                 "country": "global",
#                 "environment": "dev",
#                 "managed_by": "portal",
#                 "owner": "not_applicable",
#                 "status": "to_review"
#             },
#             "properties": {}
#         }
}
