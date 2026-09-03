resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "${var.project_name}-igw"
  }
}


resource "aws_lb" "main" {
    name =  "${var.project_name}-lb"
    internal = false
    load_balancer_type = "application"
    
    security_groups =[ aws_security_group.web.id]
    subnets = aws_subnet.public_subnets[*].id

   tags = {
    Name = "${var.project_name}-alb"
  }
}

resource "aws_lb_target_group" "web" {
   name =  "${var.project_name}-tg"
   port = 80
   protocol = "HTTP"
   vpc_id = aws_vpc.main.id

   health_check {
     enabled = true
     
   }

}