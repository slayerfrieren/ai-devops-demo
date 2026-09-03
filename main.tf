locals {
  region = "us-west-2"

  tags = {
    owner       = "build-team"
    cost_center = "engineering"
    environment = "dev"
    service     = "build-service"
  }
}

provider "aws" {
  region = local.region
}
