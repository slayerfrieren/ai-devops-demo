# Region is a literal: the org's restrict-region policy requires an
# approved region set directly (us-east-2), not via a variable or local.

locals {
  tags = {
    owner       = "build-team-seattle"
    cost_center = "build-service"
    environment = "dev"
    service     = "build-service"
  }
}

provider "aws" {
  region = "us-east-2"
}
