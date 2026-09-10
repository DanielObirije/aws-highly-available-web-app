
resource "aws_autoscaling_group" "main" {
  name = "${var.project_name}-asg"

  min_size = 2
  desired_capacity = 2
  max_size = 5

  vpc_zone_identifier =  aws_subnet.public_subnets[*].id

  health_check_type = "EC2"
  health_check_grace_period = 300

  target_group_arns = [
    aws_lb_target_group.web.arn
  ]

  launch_template {
    id = aws_launch_template.main.id
    version = "$Latest"
  }

  enabled_metrics = [
    "GroupDesiredCapacity",
    "GroupInServiceCapacity",
    "GroupPendingCapacity",
    "GroupMinSize",
    "GroupMaxSize",
    "GroupTotalCapacity",
    "GroupTotalInstances",
    "GroupInServiceInstances",
    "GroupPendingInstances",
    "GroupStandbyInstances",
    "GroupStandbyCapacity",
    "GroupTerminatingCapacity",
    "GroupTerminatingInstances"
  ]

  tag {
    key                 = "Name"
    value               = "${var.project_name}-ASG"
    propagate_at_launch = true
  }
  depends_on = [
    aws_lb_listener.http
  ]
}


resource "aws_autoscaling_policy" "name" {
  name = "${var.project_name}-target-tracking"
  autoscaling_group_name = aws_autoscaling_group.main
  policy_type =  "TargetTrackingScaling"
  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }
    target_value = 50
    disable_scale_in = false
  }
}