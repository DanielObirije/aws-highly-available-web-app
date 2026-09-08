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



