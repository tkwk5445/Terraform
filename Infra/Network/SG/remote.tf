data "terraform_remote_state" "project03_vpc" {
  backend = "s3"
  config = {
    bucket = "project03-terraform-state"
    key    = "project03/Infra/Network/VPC/terraform.tfstate"
    region = "ap-northeast-2"
  }
}
