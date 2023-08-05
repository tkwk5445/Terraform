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

data "terraform_remote_state" "eip" {

  backend = "s3"
  config = {
    bucket = "project03-terraform-state"

    key    = "project03/Infra/Network/VPC/terraform.tfstate"
    region = "ap-northeast-2"
  }
}
