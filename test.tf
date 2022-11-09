terraform {
  required_providers {
    azurerm = {
      # https://github.com/terraform-providers/terraform-provider-azurerm
      source  = "hashicorp/azurerm"
      version = "~> 3.9.0"
    }
  }
  required_version = ">= 1.2.6"
}

provider "azurerm" {
  features {}
}

data "azurerm_subscription" "primary" {}
data "azurerm_client_config" "current" {}

variable "location" {
  type    = string
  default = "canadacentral"
}

locals {
  accountName = "ssc11-2-test-please-delete"
  resource_group_name = "ScDc-CIO_ESLZ_light_Project-rg"
}

# resource "azurerm_resource_group" "rg" {
#   name     = "TFRDemo"
#   location = "australiasoutheast"
# }
# resource "azurerm_template_deployment" "arm" {
#   name                = "arm"
#   resource_group_name = azurerm_resource_group.rg.name
#   template_body       = file("azuredeploy.jason")


#   deployment_mode = "Incremental"
# }

resource "azurerm_resource_group_template_deployment" "DevOps_Org_Create" {
  name                = local.accountName
  resource_group_name = local.resource_group_name
  deployment_mode     = "Incremental"
  parameters_content = jsonencode({
    "accountName" = {
      value = local.accountName
    }
  })
  template_content = <<TEMPLATE
{
    "$schema": "https://schema.management.azure.com/schemas/2014-04-01-preview/deploymentTemplate.json#",
    "contentVersion": "1.0.0.0",
    "parameters": {
        "accountName": {
            "type": "String",
            "metadata": {
                "description": "Name of the Azure DevOps organization to be created by terraform."
            }
        }
    },
    "variables": {},
    "resources": [
        {
            "type": "Microsoft.VisualStudio/account",
            "apiVersion": "2014-04-01-preview",
            "name": "[parameters('accountName')]",
            "location": "[resourceGroup().location]",
            "dependsOn": [],
            "tags": {},
            "properties": {
                "operationType": "Create",
                "accountName": "[parameters('accountName')]"
            },
            "resources": []
        }
    ]
}
TEMPLATE

  // NOTE: whilst we show an inline template here, we recommend
  // sourcing this from a file for readability/editor support
}
