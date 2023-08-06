data "terraform_remote_state" "project03_target" {

  backend = "s3"
  config = {
    bucket = var.remote_state_bucket
    key    = var.remote_state_target_instance
    region = var.remote_state_region
  }
}
