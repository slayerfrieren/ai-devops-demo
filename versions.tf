terraform {
  required_version = ">= 1.9.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.70"
    }
  }
}

provider "aws" {
  region = var.region

  default_tags {
    tags = {
      owner       = "build-team"
      cost_center = "eng-build"
      environment = "dev"
      service     = "build-service"
    }
  }
}
