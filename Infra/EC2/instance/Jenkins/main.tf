resource "aws_instance" "project03-jenkins-ec2" {
  ami           = data.aws_ami.ubuntu.image_id
  instance_type = "t3.large"
  key_name      = var.key
  # Security group ( ssh, web )
  vpc_security_group_ids = [
    data.terraform_remote_state.project03_SG.outputs["project03-ssh"],
    data.terraform_remote_state.project03_SG.outputs["project03-web"],
  ]
  # IAM
  iam_instance_profile        = data.aws_iam_role.target.id
  subnet_id                   = data.terraform_remote_state.project03_VPC.outputs.private_subnet2a
  availability_zone           = var.azs[0] # ap-northeast-2a
  associate_public_ip_address = false
  user_data                   = <<-EOF
              #!/bin/bash
              sudo apt update -y && sudo apt install -y zip
              cd /home/ubuntu && sudo git clone https://github.com/tkwk5445/jenkins_Scripts.git 
              cd jenkins_Scripts/ && sudo chmod u+x *.sh
              sudo chmod u+x install-docker.sh
              sudo ./install-docker.sh && sudo ./install-docker-compose.sh && docker-compose up -d --build
              EOF
  tags = {
    Name = "project03-jenkins-ec2"
  }
}
