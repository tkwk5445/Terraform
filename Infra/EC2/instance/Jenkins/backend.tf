terraform {
  backend "s3" {

    bucket = "project03-terraform-state"
    key    = "Infra/EC2/Instance/Jenkins/terraform.tfstate"
    region = "ap-northeast-2"

    dynamodb_table = "project03-terraform-locks"
    encrypt        = true
  }
}
