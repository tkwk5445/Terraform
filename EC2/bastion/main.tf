resource "aws_instance" "project03-bastion-ec2" {
  ami           = data.aws_ami.ubuntu.image_id
  instance_type = "t2.micro"
  key_name      = "project03-key"

  vpc_security_group_ids = [data.terraform_remote_state.project03_sg.outputs["project03-ssh"]]

  subnet_id                   = data.terraform_remote_state.project03_vpc.outputs.public_subnet2a
  availability_zone           = "ap-northeast-2a"
  associate_public_ip_address = true

  tags = {
    Name = "project03-bastion-ec2"
  }
}
