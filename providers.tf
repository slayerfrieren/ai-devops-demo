provider "aws" {
  region = "us-east-2"

  default_tags {
    tags = {
      owner       = "build-team"
      cost_center = "build"
    }
  }
}
