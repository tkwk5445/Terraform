variable "remote_state_bucket" {
  description = "The name of the S3 bucket storing the remote state."
  default     = "project03-terraform-state"
}

variable "remote_state_sg" {
  description = "The key of the remote state file for the security group in the S3 bucket."
  default     = "Infra/Network/SG/terraform.tfstate"
}

variable "remote_state_vpc" {
  description = "The key of the remote state file for the VPC in the S3 bucket."
  default     = "Infra/Network/VPC/terraform.tfstate"
}

variable "remote_state_launch-template" {
  description = "The key of the remote state file for the Launch Template in the S3 bucket."
  default     = "Infra/EC2/Launch-template/terraform.tfstate"
}

variable "remote_state_target-group" {
  description = "The key of the remote state file for the lb's target group in the S3 bucket."
  default     = "Infra/EC2/lb/terraform.tfstate"
}

variable "remote_state_region" {
  description = "The AWS region where the S3 bucket storing the remote state is located."
  default     = "ap-northeast-2"
}
