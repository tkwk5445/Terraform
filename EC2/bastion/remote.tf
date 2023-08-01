data "terraform_remote_state" "project03_sg" {
  
  backend = "s3"
  config = {
    bucket = "project03-terraform-state"
   
    key    = "project03/sg/terraform.tfstate"
    region = "ap-northeast-2"
  }
}

data "terraform_remote_state" "project03_vpc" {
  
  backend = "s3"
  config = {
    bucket = "project03-terraform-state"

    key    = "project03/vpc/terraform.tfstate"
    region = "ap-northeast-2"
  }
}