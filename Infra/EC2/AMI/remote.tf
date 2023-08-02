data "terraform_remote_state" "project03_target" {

  backend = "s3"
  config = {
    bucket = "project03-terraform-state"

    key    = "project03/Infra/EC2/Target/terraform.tfstate"
    region = "ap-northeast-2"
  }
}
