# Build service dev VM — small instance, default VPC, no inbound exposure
# beyond what the default security group allows.

data "aws_ami" "al2023" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-2023.*-x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_instance" "build" {
  ami           = data.aws_ami.al2023.id
  instance_type = "t3.micro"

  tags = {
    Name        = "build-service-dev"
    owner       = "build-team"
    cost_center = "build"
  }
}
