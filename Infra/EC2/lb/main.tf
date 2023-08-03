# Create Target group 
resource "aws_lb_target_group" "project03-target-group" {
  name     = "project03-target-group"
  port     = 8080
  protocol = "HTTP"
  vpc_id   = data.terraform_remote_state.project03_VPC.outputs.vpc_id
  health_check {
    path                = "/"
    protocol            = "HTTP"
    matcher             = "200"
    interval            = 15
    timeout             = 3
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }
}

# Target instances for Jenkins (Jenkins EC2 instance)
resource "aws_lb_target_group_attachment" "ALB_Jenkins" {
  target_group_arn = aws_lb_target_group.project03-target-group.arn
  target_id        = data.terraform_remote_state.project03-jenkins.outputs.jenkins-EC2
  port             = 8080
}

/* # Target instances for Auto Scaling Group (ASG instances)
resource "aws_lb_target_group_attachment" "ALB_ASG" {
  for_each         = toset(data.terraform_remote_state.project03-GROUP.outputs.instance_ids)
  target_group_arn = aws_lb_target_group.project03-target-group.arn
  target_id        = each.key
  port             = 8080
} */
# Create loadbalancer
resource "aws_lb" "project03-lb" {
  name               = "project03-lb"
  load_balancer_type = "application"
  subnets = [
    data.terraform_remote_state.project03_VPC.outputs.public_subnet2a,
    data.terraform_remote_state.project03_VPC.outputs.public_subnet2c
  ]
  security_groups = [data.terraform_remote_state.project03_SG.outputs.project03-web]
}

# ALB listener
resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.project03-lb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.project03-target-group.arn
  }
}
resource "aws_lb_listener" "https" {
  load_balancer_arn = aws_lb.project03-lb.arn
  port              = 443
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-TLS13-1-2-2021-06"
  certificate_arn   = "arn:aws:acm:ap-northeast-2:257307634175:certificate/8238361a-128b-464c-81fe-c4108d9e5ab2"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.project03-target-group.arn
  }
}
# ALB listener rule for "/jenkins*"
resource "aws_lb_listener_rule" "jenkins" {
  listener_arn = aws_lb_listener.http.arn
  priority     = 100

  condition {
    path_pattern {
      values = ["/jenkins*"]
    }
  }

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.project03-target-group.arn
  }
}

# ALB listener rule for default path
resource "aws_lb_listener_rule" "default" {
  listener_arn = aws_lb_listener.http.arn
  priority     = 99

  condition {
    path_pattern {
      values = ["/*"]
    }
  }

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.project03-target-group.arn
  }
}
