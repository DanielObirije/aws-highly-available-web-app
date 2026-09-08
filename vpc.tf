resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr
  enable_dns_support = true
  enable_dns_hostnames = true
  tags ={
    Name = "${var.project_name}-vpc"
  }
}

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "${var.project_name}-igw"
  }
}


resource "aws_subnet" "public_subnets" {
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

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id
  route = {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }
   tags ={
    Name = "${var.project_name}-rt"
  }
}

resource "aws_route_table_association" "public" {
 count = 3
 subnet_id = aws_subnet.public_subnets[count.index].id
 route_table_id = aws_route_table.public.id
}


resource "aws_security_group" "web" {
  name =  "${var.project_name}-web-sg"
  description = "Allow HTTP and SSH"
  vpc_id = aws_vpc.main.id

  ingress  {
    description = "HTTP"
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress{
    description = "SSH"
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  egress = {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
   tags ={
    Name = "${var.project_name}-web-sg"
  }
}
