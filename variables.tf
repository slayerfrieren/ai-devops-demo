variable "region" {
  description = "AWS region for the build service dev environment."
  type        = string
  default     = "us-west-2"
}

variable "instance_type" {
  description = "Instance type for the build VM."
  type        = string
  default     = "t3.micro"
}
