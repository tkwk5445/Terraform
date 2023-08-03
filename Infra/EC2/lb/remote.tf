data "terraform_remote_state" "project03_VPC" {
    backend = "s3"
    config = {
        bucket = "project03-terraform-state"
        key    = "project03/Infra/Network/VPC/terraform.tfstate"
        region = "ap-northeast-2"
    }
}

data "terraform_remote_state" "project03_SG" {

  backend = "s3"
  config = {
    bucket = "project03-terraform-state"

    key    = "project03/Infra/Network/SG/terraform.tfstate"
    region = "ap-northeast-2"
  }
}

data "terraform_remote_state" "project03-jenkins" {

  backend = "s3"
  config = {
    bucket = "project03-terraform-state"

    key    = "project03/Infra/EC2/Instance/Jenkins/terraform.tfstate"
    region = "ap-northeast-2"
  }
}

data "terraform_remote_state" "aws_lb_target_group_id" {

  backend = "s3"
  config = {
    bucket = "project03-terraform-state"

    key    = "project03/Infra/EC2/lb/terraform.tfstate"
    region = "ap-northeast-2"
  }
}

data "terraform_remote_state" "aws_lb_target_group_arn" {

  backend = "s3"
  config = {
    bucket = "project03-terraform-state"

    key    = "project03/Infra/EC2/lb/terraform.tfstate"
    region = "ap-northeast-2"
  }
}
/*
data "terraform_remote_state" "launch_template" {
  backend = "s3"
  config = {
    bucket = "project03-terraform-state"

    key    = "project03/Infra/EC2/Launch-Template/terraform.tfstate"
    region = "ap-northeast-2"
  }
}*/