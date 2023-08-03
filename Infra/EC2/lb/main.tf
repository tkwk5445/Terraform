provider "aws" {
  region = "ap-northeast-2"
}

# ◀◀◀◀◀◀◀◀ 대상그룹 생성 ▶▶▶▶▶▶▶▶
resource "aws_lb_target_group" "project03-target-group" {
  name     = "project03-target-group"
  port     = var.server_port
  protocol = "HTTP"
  vpc_id   = data.terraform_remote_state.project03_VPC.outputs.vpc_id

  # 대상그룹의 상태검사
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

# ◀◀◀◀◀◀◀◀ 로드밸런서 생성 ▶▶▶▶▶▶▶▶
resource "aws_lb" "project03-lb" {
  name               = "project03-lb"
  load_balancer_type = "application"
  # 로드밸런스 생성되는 vpc의 서브넷
  subnets = [
    data.terraform_remote_state.project03_VPC.outputs.public_subnet2a,
    data.terraform_remote_state.project03_VPC.outputs.public_subnet2c
  ]
  # 로드밸런스에 사용할 보안 그룹 
  security_groups = [data.terraform_remote_state.project03_SG.outputs.project03-web]
}
# 로드밸런스에 연결할 대상그룹
/* resource "aws_lb_target_group_attachment" "aws_lb_target_group_attachment" {
    target_group_arn = data.terraform_remote_state.aws_lb_target_group.outputs.target_group_arn
    target_id        = data.terraform_remote_state.aws_lb_target_group.outputs.target_group_id
    port             = 8080
} */
# 로드밸런스에 연결한 대상 인스턴스
resource "aws_lb_target_group_attachment" "ALB_Jenkins" {
  target_group_arn = aws_lb_target_group.project03-target-group.arn
  target_id        = data.terraform_remote_state.project03-jenkins.outputs.jenkins-EC2
  port             = 8080
}

# ALB 리스너
resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.project03-lb.arn
  port              = 80
  protocol          = "HTTP"

  # 기본값으로 단순한 404 페이지 오류를 반환한다.
  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      message_body = "404: page not found"
      status_code  = 404
    }
  }
}

/* resource "aws_lb_listener" "https" {
  load_balancer_arn       = aws_lb.project03-lb.arn
  port                    = 443
  protocol                = "HTTPS"
  ssl_policy              = "ELBSecurityPolicy-2016-08"
  certifiacertificate_arn =  */

# 기본값으로 단순한 404 페이지 오류를 반환한다.
default_action {
  type = "forward"
  #target_group_arn = aws_lb_target_group.project03-target-group.arn
}
#}
# ALB 리스너 규칙
resource "aws_lb_listener_rule" "asg" {
  listener_arn = aws_lb_listener.http.arn

  priority = 100

  condition {
    path_pattern {
      values = ["*"]
    }
  }

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.project03-target-group.arn
  }
}

/* data "aws_vpc" "project03_vpc" {
  # 이름이 "asdf12345-vpc"인 VPC를 가져오도록 설정합니다.
  filter {
    name   = "tag:Name"
    values = ["project03_vpc"]
  }
} */

/* data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.project03_vpc.id]
  }
} */
/*
data "template_file" "web_output" {
  template = file("${path.module}/web.sh")
  vars = {
    server_port = "${var.server_port}"
  }
}*/

variable "server_port" {
  description = "The port will use for HTTP requests"
  type        = number
  default     = 8080
}

