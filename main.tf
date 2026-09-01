# locals {
#   project     = "ha-web"
#   environment = "dev"
#   suffix      = "${local.project}-${local.environment}"

#   resource_names = {
#     vpc                = "vpc-${local.suffix}"
#     internet_gateway   = "igw-${local.suffix}"
#     public_subnet      = "public-subnet-${local.suffix}"
#     private_subnet     = "private-subnet-${local.suffix}"
#     security_group     = "sg-${local.suffix}"
#     load_balancer      = "alb-${local.suffix}"
#     target_group       = "tg-${local.suffix}"
#     launch_template    = "lt-${local.suffix}"
#     auto_scaling_group = "asg-${local.suffix}"
#   }

#   aws_config = {
#     region        = "us-east-1"
#     vpc_cidr      = "10.0.0.0/16"
#     instance_type = "t3.micro"

#     desired_capacity = 2
#     min_size         = 2
#     max_size         = 5
#   }

#   common_tags = {
#     Project     = local.project
#     Environment = local.environment
#     Managed_By  = "Terraform"
#   }
# }


data "aws_avaliblity_zone" "available" {}

data "aws_ami" "ubuntu_sql" {
  most_recent = true
  owners      = ["061579646519"]

  filter {
    name   = "image-id"
    values = ["ami-091b599f5f318ddd2"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "ena-support"
    values = ["true"]
  }
}


