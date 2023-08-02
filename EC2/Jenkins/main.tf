
resource "aws_instance" "project03-jenkins-ec2" {
  ami           = "ami-0c9c942bd7bf113a2"
  instance_type = "t3.large" # 원하는 인스턴스 유형을 지정하세요.
  key_name      = "project03-key"

  vpc_security_group_ids = [
    data.terraform_remote_state.project03_SG.outputs["project03-ssh"]
  ]

  subnet_id                   = data.terraform_remote_state.project03_VPC.outputs.public_subnet2a
  availability_zone           = "ap-northeast-2a"
  associate_public_ip_address = true
  user_data                   = <<-EOF
              #!/bin/bash

              cd /home/ubuntu
              sudo git clone https://github.com/KYLGZR0224/jenkins_Scripts.git

              cd jenkins_Scripts/

              sudo chmod u+x install-docker.sh
              ./install-docker.sh

              sudo chmod u+x install-docker-compose.sh
              ./install-docker-compose.sh

              EOF

  tags = {
    Name = "project03-jenkins-ec2"
  }
}
