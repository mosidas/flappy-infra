locals {
  app = var.app_name

  tags = {
    app = local.app
    env = "prod"
  }

  location = {
    main = "japaneast"
    sub  = "japanwest"
  }

  resource_group = {
    name     = "rg-${local.app}-${local.tags.env}"
    location = local.location.main
  }
}

