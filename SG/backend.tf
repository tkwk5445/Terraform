terraform {
  backend "s3" {
    # 이전에 생성한 버킷 이름으로 변경
    bucket         = "project03-terraform-state"
    key            = "project03/Infra/Network/SG/terraform.tfstate"
    region         = "ap-northeast-2"
    dynamodb_table = "project03-terraform-locks"
    encrypt        = true
  }
}
