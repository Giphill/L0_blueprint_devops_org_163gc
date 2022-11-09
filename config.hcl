locals {
  domain = {
    private = {
      name                 = "cio-dev-eslz-light.local"
      registration_enabled = true
    }
    public = {
      zone1 = "cio-dev-eslz-light.ssc-spc.cloud-nuage.canada.ca"
    }
  }
  env                  = "ScDc"
  group                = "CIO"
  location             = "canadacentral"
  project              = "ESLZ-light"
  core_subscription_id = "e95674c0-89ba-48df-991f-73ec4c7cbe90" # <- ID of the BCA Corew subscription
  subscription_id      = "75eea6e9-de40-430f-886f-21a5eb5f150d" # <- Client/Project subscription ID
  tags = {
    branch            = "CIO"
    builder           = "bernard.maltais@ssc-spc.gc.ca"
    classification    = "pbmm"
    cloudusageprofile = "3"
    contact           = "<some email>; <some email>; etc"
    costcentre        = "566811"
    env               = "dev"
    owner             = "<some email>; <some email>; etc"
  }
}
