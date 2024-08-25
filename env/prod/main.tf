variable "app_name" {
  description = "The name of the application"
}

variable "api_root" {
  description = "The root URL of the API"
}

module "resourcegroup" {
  source   = "../../modules/resourcegroup"
  name     = local.resource_group.name
  location = local.location.main
  tags     = local.tags
}

resource "random_id" "app" {
  byte_length = 4
}

module "webapp" {
  source                = "../../modules/webapp"
  app_service_plan_name = "asp-${local.app}-${local.tags.env}"
  app_service_name      = "app-${local.app}-${local.tags.env}-001"
  os_type               = "Linux"
  sku_name              = "B1"
  go_version            = "1.19"
  location              = local.location.main
  resource_group_name   = module.resourcegroup.resource_group_name
  app_settings = {
    WEBSITE_RUN_FROM_PACKAGE = "1"
  }
  tags = local.tags
}

module "staticwebapp" {
  source              = "../../modules/staticwebapp"
  app_name            = "stapp-${local.app}-${local.tags.env}-002"
  location            = "eastasia"
  resource_group_name = module.resourcegroup.resource_group_name
  sku_tier            = "Free"
  app_settings = {
    API_ROOT = var.api_root
  }
  tags = local.tags
}
