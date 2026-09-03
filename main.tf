locals {
  region      = "us-east-1"
  environment = "dev"
  service     = "build-service"

  tags = {
    owner       = "build-team-seattle"
    cost_center = "engineering-build"
    environment = local.environment
    service     = local.service
    managed_by  = "terraform"
  }
}

provider "aws" {
  region = local.region
}
