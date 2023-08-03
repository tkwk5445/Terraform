# AWS autoscaling group create
resource "aws_autoscaling_group" "project03-GROUP" {

  name             = "project03-GROUP"
  desired_capacity = 3
  min_size         = 3
  max_size         = 3
  vpc_zone_identifier = [data.terraform_remote_state.project03_VPC.outputs.private_subnet2a,
  data.terraform_remote_state.project03_VPC.outputs.private_subnet2c]

  launch_template {
    id      = data.terraform_remote_state.project03_launch-template.outputs.target-launch_template
    version = "$Latest"
  }
  tag {
    key                 = "Name"
    value               = "project03-GROUP"
    propagate_at_launch = true
  }
}

