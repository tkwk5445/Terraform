# Target group ( jenkins )
resource "aws_lb_target_group" "project03-target-group-jenkins" {
  name     = "project03-target-group-jenkins"
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

# 대상 등록 ( jenkins instance )
resource "aws_lb_target_group_attachment" "ALB_Jenkins" {
  target_group_arn = aws_lb_target_group.project03-target-group-jenkins.arn
  target_id        = data.terraform_remote_state.project03_jenkins.outputs.jenkins-EC2
  port             = 8080
}

# Target group ( petclinic ) / 대상 등록은 autoscaling에서 적용
resource "aws_lb_target_group" "project03-target-group-petclinic" {
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

# Application loadbalancer
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
    target_group_arn = aws_lb_target_group.project03-target-group-petclinic.arn
  }
}

resource "aws_lb_listener" "https" {
  load_balancer_arn = aws_lb.project03-lb.arn
  port              = 443
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-TLS13-1-2-2021-06"
  certificate_arn   = var.https_listener_certificate_arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.project03-target-group-petclinic.arn
  }
}

resource "aws_lb_listener" "web" {
  load_balancer_arn = aws_lb.project03-lb.arn
  port              = 8080
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.project03-target-group-jenkins.arn
  }
}

# http listener rule for /petclinic*
resource "aws_lb_listener_rule" "petclinic_rule1" {
  listener_arn = aws_lb_listener.http.arn
  priority     = 100

  condition {
    path_pattern {
      values = ["/petclinic*"]
    }
  }

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.project03-target-group-petclinic.arn
  }

  tags = {
    Name = "petclinic_rule"
  }
}

# https listener rule for /petclinic*
resource "aws_lb_listener_rule" "petclinic_rule2" {
  listener_arn = aws_lb_listener.https.arn
  priority     = 100

  condition {
    path_pattern {
      values = ["/petclinic*"]
    }
  }

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.project03-target-group-petclinic.arn
  }

  tags = {
    Name = "petclinic_rule"
  }
}
