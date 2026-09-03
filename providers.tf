locals {
  region = "us-west-2"

  tags = {
    owner       = "build-team-seattle"
    cost_center = "build-service"
    environment = "dev"
    service     = "build-service"
  }
}

provider "aws" {
  region = local.region
}
