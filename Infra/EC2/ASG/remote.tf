data "terraform_remote_state" "project03_SG" {

  backend = "s3"
  config = {
    bucket = "project03-terraform-state"

    key    = "project03/Infra/Network/SG/terraform.tfstate"
    region = "ap-northeast-2"
  }
}

data "terraform_remote_state" "project03_VPC" {

  backend = "s3"
  config = {
    bucket = "project03-terraform-state"

    key    = "project03/Infra/Network/VPC/terraform.tfstate"
    region = "ap-northeast-2"
  }
}

data "terraform_remote_state" "project03_launch-template" {

  backend = "s3"
  config = {
    bucket = "project03-terraform-state"

    key    = "project03/Infra/EC2/Launch-template/terraform.tfstate"
    region = "ap-northeast-2"
  }
}

data "terraform_remote_state" "project03_target" {

  backend = "s3"
  config = {
    bucket = "project03-terraform-state"

    key    = "project03/Infra/EC2/lb/terraform.tfstate"
    region = "ap-northeast-2"
  }
}
