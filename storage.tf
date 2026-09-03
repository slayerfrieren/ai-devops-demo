# Build artifact bucket from the platform team's trusted catalog module.

module "build_artifacts" {
  source  = "app.terraform.io/demo-vault-platform-tour/s3-bucket/aws"
  version = "1.6.0"

  bucket_name = "build-service-artifacts"
  region      = "us-east-2"

  tags = {
    owner       = "build-team"
    cost_center = "build"
  }
}

output "build_artifacts_bucket_name" {
  description = "Artifact bucket name (includes uniqueness suffix)."
  value       = module.build_artifacts.bucket_name
}

output "build_artifacts_bucket_arn" {
  description = "Artifact bucket ARN for the build service's IAM policy."
  value       = module.build_artifacts.bucket_arn
}
