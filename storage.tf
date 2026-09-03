module "build_artifacts" {
  source  = "app.terraform.io/demo-vault-platform-tour/s3-bucket/aws"
  version = "1.6.0"

  bucket_name = "build-service-artifacts-dev"
  region      = "us-east-2"

  tags = {
    owner       = "build-team"
    cost_center = "build-eng"
  }
}
