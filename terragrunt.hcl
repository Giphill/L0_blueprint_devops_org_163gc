locals {
  config  = read_terragrunt_config("./config.hcl").locals
}

terraform {
  source = "./"
  # source = "git@ssh.dev.azure.com:v3/ssc-spc-cloud-nuage/ESLZ-light_template/${basename(get_terragrunt_dir())}///?ref=${local.release}"

  extra_arguments "force_subscription" {
    commands = [
      "init",
      "apply",
      "destroy",
      "refresh",
      "import",
      "plan",
      "refresh"
    ]
    env_vars = {
      ARM_SUBSCRIPTION_ID = local.config.billing_subscription
    }
  }
}
remote_state {
  # Disabling since it's causing issues as per 	
  # https://github.com/gruntwork-io/terragrunt/pull/1317#issuecomment-682041007	
  disable_dependency_optimization = true

  backend = "azurerm"
  generate = {
    path      = "backend.azurerm.tf"
    if_exists = "overwrite"
  }
  config = {
     subscription_id = local.config.backend_subscription

    // # Data from Rover Launchpad
    resource_group_name  = local.config.backend_resource_group
    storage_account_name = local.config.backend_storage_account
    container_name       = local.config.backend_container_name

   key = "devops/org/${local.config.org_name}/terraform.tfstate"
  }
}

inputs = {
  org_name  = local.config.org_name
  env = local.config.env
  group = local.config.group
  tags = local.config.tags
}

