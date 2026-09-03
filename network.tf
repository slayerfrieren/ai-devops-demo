# Minimal dedicated network for the build service dev environment.

resource "aws_vpc" "build" {
  cidr_block           = "10.42.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = merge(local.tags, { Name = "${local.service}-${local.environment}" })
}

resource "aws_subnet" "build" {
  vpc_id                  = aws_vpc.build.id
  cidr_block              = "10.42.1.0/24"
  availability_zone       = "${local.region}a"
  map_public_ip_on_launch = false

  tags = merge(local.tags, { Name = "${local.service}-${local.environment}-a" })
}

resource "aws_security_group" "build" {
  name        = "${local.service}-${local.environment}"
  description = "Build service dev VM: no inbound, outbound to fetch dependencies"
  vpc_id      = aws_vpc.build.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(local.tags, { Name = "${local.service}-${local.environment}" })
}
