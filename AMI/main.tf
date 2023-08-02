resource "aws_ami_from_instance" "project03-target" {
  name               = "project03-target-ami"
  source_instance_id = data.terraform_remote_state.project03_target.outputs.target-EC2
  tags = {
    Name = "project03-target-ami"
  }
}
