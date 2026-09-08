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

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.main.arn
  port = "80"
  protocol = "HTTP"

  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.web.arn
  }
}

resource "aws_lb_target_group" "web" {
   name =  "${var.project_name}-tg"
   port = 80
   protocol = "HTTP"
   vpc_id = aws_vpc.main.id

   health_check {
     enabled = true
     protocol = "HTTP"
     port = "80"
     path = "/"

     healthy_threshold = 3
     unhealthy_threshold = 2

     timeout = 5
     interval = 20

     matcher = "200"
   }

   tags = {
    Name = "${var.project_name}-tg"
  }
}

