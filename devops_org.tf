



module "resource_groups_L1" {
  source   = "github.com/canada-ca-terraform-modules/terraform-azurerm-caf-resource_groups?ref=v1.1.0"
  userDefinedString = "${var.org_name}_org"
  env               = var.env
  location          = var.location
  tags              = var.tags
}



resource "azurerm_resource_group_template_deployment" "DevOps_Org_Create" {
  name                = var.org_name
  resource_group_name = module.resource_groups_L1.name
  deployment_mode     = "Incremental"
  parameters_content = jsonencode({
    "accountName" = {
      value = var.org_name
    }
  })
  template_content = file("org.json")
}


