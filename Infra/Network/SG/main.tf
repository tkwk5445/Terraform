
resource "aws_security_group" "project03-WEB" {
  name        = "project03-WEB"
  description = "security group for web server"
  vpc_id      = data.terraform_remote_state.project03_vpc.outputs.vpc_id

  #인바운드 80, 443, 8080 허용
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  #모든 아웃바운드 트래픽 허용
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "project03-WEB"
  }
}

resource "aws_security_group" "project03-SSH" {
  name        = "project03-SSH"
  description = "security group for ssh server"
  vpc_id      = data.terraform_remote_state.project03_vpc.outputs.vpc_id

  ingress {
    description = "For ssh port"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "project03-SSH"
  }
}
