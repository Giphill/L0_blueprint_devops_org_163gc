locals {
  config  = read_terragrunt_config("config.hcl").locals
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
      ARM_SUBSCRIPTION_ID = local.config.subscription_id
    }
  }
}

inputs = {
  location = local.config.location
}