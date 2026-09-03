# Build artifact bucket from the platform team's catalog module
# (encryption, versioning, public-access block, and lifecycle baked in).

module "artifacts" {
  source  = "app.terraform.io/demo-vault-platform-tour/s3-bucket/aws"
  version = "1.6.0"

  bucket_name = "build-service-dev-artifacts"
  region      = "us-east-2"
  tags        = local.tags
}
