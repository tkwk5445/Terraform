resource "aws_launch_template" "project03-launch-template" {
  name          = "project03-launch-template"
  instance_type = "t2.micro"
  image_id      = data.terraform_remote_state.project03_AMI.outputs.target-ami
  key_name      = var.key
  # Security group ( ssh, web )
  vpc_security_group_ids = [
    data.terraform_remote_state.project03_SG.outputs["project03-ssh"],
    data.terraform_remote_state.project03_SG.outputs["project03-web"],
  ]
  # IAM
  iam_instance_profile {
    name = data.aws_iam_role.target.name
  }
  tags = {
    Name = "project03-codedeploy-launch-template"
  }
  lifecycle {
    create_before_destroy = true
  }
}
