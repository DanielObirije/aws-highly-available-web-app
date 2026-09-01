resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr
  enable_dns_support = true
  enable_dns_hostnames = true
  tags ={
    Name = "${var.project_name}-vpc"
  }
}

resource "aws_subnet" "public_subnet" {
  count = 3
  vpc_id = aws_vpc.main.id
  cidr_block = [
    var.public_subnet_1_cidr,
    var.public_subnet_2_cidr,
    var.public_subnet_3_cidr
  ]
  map_public_ip_on_launch = true

  tags ={
    Name = "${var.project_name}-public-subnet-${count.index + 1}"
  }
}


