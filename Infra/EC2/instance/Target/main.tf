resource "aws_instance" "project03-target-ec2" {
  ami           = data.aws_ami.ubuntu.image_id
  instance_type = "t2.micro"
  key_name      = var.key
  # Security group ( ssh, web )
  vpc_security_group_ids = [
    data.terraform_remote_state.project03_SG.outputs["project03-ssh"],
    data.terraform_remote_state.project03_SG.outputs["project03-web"],
  ]
  # IAM
  iam_instance_profile        = data.aws_iam_role.target.id
  subnet_id                   = data.terraform_remote_state.project03_VPC.outputs.private_subnet2a
  availability_zone           = var.azs[0]
  associate_public_ip_address = false
  user_data                   = <<-EOF
              #!/bin/bash
              sudo apt update
              sudo apt install -y docker.io git default-jre ruby wget unzip
              sudo apt install -y stress

              curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
              unzip awscliv2.zip
              sudo ./aws/install

              cd /home/ubuntu
              wget -O install https://aws-codedeploy-ap-northeast-2.s3.amazonaws.com/latest/install
              chmod +x ./install
              sudo ./install auto
              sudo service codedeploy-agent status
              rm -rf ./install

              sudo cat <<'CODEDEPLOY_START_SCRIPT' > /etc/init.d/codedeploy-start.sh
              #!/bin/bash
              sudo service codedeploy-agent restart
              sudo systemctl restart docker
              CODEDEPLOY_START_SCRIPT
              sudo chmod +x /etc/init.d/codedeploy-start.sh

              sudo usermod -aG docker ubuntu
              sudo systemctl enable docker
              sudo systemctl start docker

              sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
              sudo chmod +x /usr/local/bin/docker-compose
              EOF
  tags = {
    Name = "project03-target-ec2"
  }
}
