output "instance_id" {
  description = "Build VM instance id (connect with: aws ssm start-session --target <id>)."
  value       = aws_instance.build.id
}

output "artifact_bucket" {
  description = "Build artifact bucket name."
  value       = module.artifacts.bucket_name
}
