output "build_vm_id" {
  description = "Instance ID of the build service dev VM."
  value       = aws_instance.build.id
}

output "build_vm_private_ip" {
  description = "Private IP of the build service dev VM."
  value       = aws_instance.build.private_ip
}

output "artifact_bucket_name" {
  description = "Build artifact bucket name."
  value       = module.build_artifacts.bucket_name
}

output "artifact_bucket_arn" {
  description = "Build artifact bucket ARN."
  value       = module.build_artifacts.bucket_arn
}
