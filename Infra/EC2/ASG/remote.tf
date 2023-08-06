data "terraform_remote_state" "project03_SG" {
  backend = "s3"
  config = {
    bucket = var.remote_state_bucket
    key    = var.remote_state_sg
    region = var.remote_state_region
  }
}

data "terraform_remote_state" "project03_VPC" {
  backend = "s3"
  config = {
    bucket = var.remote_state_bucket
    key    = var.remote_state_vpc
    region = var.remote_state_region
  }
}

data "terraform_remote_state" "project03_launch-template" {
  backend = "s3"
  config = {
    bucket = var.remote_state_bucket
    key    = var.remote_state_launch-template
    region = var.remote_state_region
  }
}

data "terraform_remote_state" "project03_lb_target" {
  backend = "s3"
  config = {
    bucket = var.remote_state_bucket
    key    = var.remote_state_target-group
    region = var.remote_state_region
  }
}
