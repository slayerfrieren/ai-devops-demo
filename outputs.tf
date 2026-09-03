output "build_instance_id" {
  description = "Instance ID of the build service dev VM."
  value       = aws_instance.build.id
}

output "artifact_bucket_name" {
  description = "Full name of the build artifact bucket."
  value       = module.build_artifacts.bucket_name
}

output "artifact_bucket_arn" {
  description = "ARN of the build artifact bucket."
  value       = module.build_artifacts.bucket_arn
}
