variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "project_name" {
  description = "highly available web application"
  type        = string
  default     = "aws-highly-available-web-app"
}

variable "vpc_cidr" {
  description = "VPC CIDR"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_1_cidr" {
  description = "Public subnet 1 CIDR"
  type        = string
  default     = "10.0.1.0/24"
}

variable "public_subnet_2_cidr" {
  description = "Public subnet 2 CIDR"
  type        = string
  default     = "10.0.2.0/24"
}

variable "public_subnet_3_cidr" {
  description = "Public subnet 3 CIDR"
  type        = string
  default     = "10.0.3.0/24"
}


variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "key_name" {
  description = "Existing EC2 key pair name"
  type        = string
}

variable "desired_capacity" {
  type    = number
  default = 2
}

variable "min_size" {
  type    = number
  default = 2
}

variable "max_size" {
  type    = number
  default = 5
}