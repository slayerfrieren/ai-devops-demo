# Small Linux VM for the build service dev environment.
# Access is via SSM Session Manager (no inbound ports, no key pair).

data "aws_ami" "al2023" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-2023.*-x86_64"]
  }
}

data "aws_iam_policy_document" "ec2_assume" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "build" {
  name               = "build-service-dev"
  assume_role_policy = data.aws_iam_policy_document.ec2_assume.json
  tags               = local.tags
}

resource "aws_iam_role_policy_attachment" "ssm" {
  role       = aws_iam_role.build.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

# Read/write to the artifact bucket only.
data "aws_iam_policy_document" "artifacts" {
  statement {
    actions   = ["s3:ListBucket"]
    resources = [module.artifacts.bucket_arn]
  }
  statement {
    actions   = ["s3:GetObject", "s3:PutObject", "s3:DeleteObject"]
    resources = ["${module.artifacts.bucket_arn}/*"]
  }
}

resource "aws_iam_role_policy" "artifacts" {
  name   = "build-artifacts-rw"
  role   = aws_iam_role.build.id
  policy = data.aws_iam_policy_document.artifacts.json
}

resource "aws_iam_instance_profile" "build" {
  name = "build-service-dev"
  role = aws_iam_role.build.name
  tags = local.tags
}

resource "aws_instance" "build" {
  ami                    = data.aws_ami.al2023.id
  instance_type          = "t3.small"
  subnet_id              = data.aws_subnets.default.ids[0]
  vpc_security_group_ids = [aws_security_group.build.id]
  iam_instance_profile   = aws_iam_instance_profile.build.name

  root_block_device {
    volume_size = 30
    volume_type = "gp3"
    encrypted   = true
  }

  metadata_options {
    http_tokens = "required"
  }

  tags = merge(local.tags, { Name = "build-service-dev" })
}
