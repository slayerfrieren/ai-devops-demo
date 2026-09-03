# Build artifact bucket from the platform team's approved catalog module.

module "build_artifacts" {
  source  = "app.terraform.io/demo-vault-platform-tour/s3-bucket/aws"
  version = "1.6.0"

  bucket_name        = "${local.service}-${local.environment}-artifacts"
  region             = local.region
  versioning_enabled = true
  lifecycle_days     = 30

  tags = local.tags
}
