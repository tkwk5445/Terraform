resource "aws_launch_template" "project03-launch-template" {
  name     = "project03-launch-template"
  image_id = data.terraform_remote_state.project03_AMI.outputs.target-ami
  key_name = "project03-key"
  vpc_security_group_ids = [data.terraform_remote_state.project03_SG.outputs["project03-ssh"],
  data.terraform_remote_state.project03_SG.outputs["project03-web"]]

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
