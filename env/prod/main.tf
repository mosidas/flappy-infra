variable "app_name" {
  description = "The name of the application"
}

module "resourcegroup" {
  source   = "../../modules/resourcegroup"
  name     = local.resource_group.name
  location = local.location.main
  tags     = local.tags
}

resource "random_pet" "suffix" {}

module "staticwebapp" {
  source              = "../../modules/staticwebapp"
  app_name            = "stapp-${local.app}-${local.tags.env}-${random_pet.suffix.id}"
  location            = "eastasia"
  resource_group_name = module.resourcegroup.resource_group_name
  sku_tier            = "Free"
  app_settings        = {}
  tags                = local.tags
}
