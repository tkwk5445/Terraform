data "terraform_remote_state" "project03_vpc" {
  backend = "s3"
  config = {
    bucket = "project03-terraform-state"
    key    = "/terraform.tfstate"
    region = "ap-northeast-2"
  }
}