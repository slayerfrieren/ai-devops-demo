module "build_artifacts" {
  source  = "app.terraform.io/demo-vault-platform-tour/s3-bucket/aws"
  version = "1.6.0"

  bucket_name = "build-service-artifacts-dev"
  region      = local.region
  tags        = local.tags
}

output "build_artifacts_bucket" {
  value       = module.build_artifacts.bucket_name
  description = "Artifact bucket for the build service."
}
