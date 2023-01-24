variable "location" {
  type        = string
  description = "The location where the resources will be deployed in Azure. For an exaustive list of locations, please use the command 'az account list-locations'."
  default     = "westeurope"

  validation {
    condition     = contains(["asia", "asiapacific", "australia", "australiacentral", "australiacentral2", "australiaeast", "australiasoutheast", "brazil", "brazilsouth", "brazilsoutheast", "canada", "canadacentral", "canadaeast", "centralindia", "centralus", "centraluseuap", "centralusstage", "eastasia", "eastasiastage", "eastus", "eastus2", "eastus2euap", "eastus2stage", "eastusstage", "eastusstg", "europe", "france", "francecentral", "francesouth", "germany", "germanynorth", "germanywestcentral", "global", "india", "japan", "japaneast", "japanwest", "jioindiacentral", "jioindiawest", "korea", "koreacentral", "koreasouth", "northcentralus", "northcentralusstage", "northeurope", "norway", "norwayeast", "norwaywest", "qatarcentral", "singapore", "southafrica", "southafricanorth", "southafricawest", "southcentralus", "southcentralusstage", "southeastasia", "southeastasiastage", "southindia", "swedencentral", "switzerland", "switzerlandnorth", "switzerlandwest", "uae", "uaecentral", "uaenorth", "uk", "uksouth", "ukwest", "unitedstates", "unitedstateseuap", "westcentralus", "westeurope", "westindia", "westus", "westus2", "westus2stage", "westus3", "westusstage"], var.location)
    error_message = format("Invalid value '%s' for variable 'location', valid options are 'asia' ,'asiapacific' ,'australia' ,'australiacentral' ,'australiacentral2' ,'australiaeast' ,'australiasoutheast' ,'brazil' ,'brazilsouth' ,'brazilsoutheast' ,'canada' ,'canadacentral' ,'canadaeast' ,'centralindia' ,'centralus' ,'centraluseuap' ,'centralusstage' ,'eastasia' ,'eastasiastage' ,'eastus' ,'eastus2' ,'eastus2euap' ,'eastus2stage' ,'eastusstage' ,'eastusstg' ,'europe' ,'france' ,'francecentral' ,'francesouth' ,'germany' ,'germanynorth' ,'germanywestcentral' ,'global' ,'india' ,'japan' ,'japaneast' ,'japanwest' ,'jioindiacentral' ,'jioindiawest' ,'korea' ,'koreacentral' ,'koreasouth' ,'northcentralus' ,'northcentralusstage' ,'northeurope' ,'norway' ,'norwayeast' ,'norwaywest' ,'qatarcentral' ,'singapore' ,'southafrica' ,'southafricanorth' ,'southafricawest' ,'southcentralus' ,'southcentralusstage' ,'southeastasia' ,'southeastasiastage' ,'southindia' ,'swedencentral' ,'switzerland' ,'switzerlandnorth' ,'switzerlandwest' ,'uae' ,'uaecentral' ,'uaenorth' ,'uk' ,'uksouth' ,'ukwest' ,'unitedstates' ,'unitedstateseuap' ,'westcentralus' ,'westeurope' ,'westindia' ,'westus' ,'westus2' ,'westus2stage' ,'westus3' ,'westusstage'.", var.location)
  }
}






