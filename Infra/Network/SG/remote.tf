data "terraform_remote_state" "project03_vpc" {
  backend = "s3"
  config = {
    bucket = var.remote_state_bucket
    key    = var.remote_state_vpc
    region = var.remote_state_region
  }
}
