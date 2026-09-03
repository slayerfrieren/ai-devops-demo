module "build_artifacts" {
  source  = "app.terraform.io/demo-vault-platform-tour/s3-bucket/aws"
  version = "1.6.0"

  region      = var.region
  bucket_name = "build-service-artifacts-dev"

  tags = {
    owner       = "build-team"
    cost_center = "eng-build"
    environment = "dev"
    service     = "build-service"
  }
}
