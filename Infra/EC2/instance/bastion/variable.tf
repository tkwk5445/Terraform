variable "remote_state_bucket" {
  description = "The name of the S3 bucket storing the remote state."
  default     = "project03-terraform-state"
}

variable "remote_state_sg" {
  description = "The key of the remote state file for the security group in the S3 bucket."
  default     = "project03/Infra/Network/SG/terraform.tfstate"
}

variable "remote_state_vpc" {
  description = "The key of the remote state file for the VPC in the S3 bucket."
  default     = "project03/Infra/Network/VPC/terraform.tfstate"
}

variable "remote_state_region" {
  description = "The AWS region where the S3 bucket storing the remote state is located."
  default     = "ap-northeast-2"
}

variable "key" {
  description = "The key name of project03-key"
  default     = "project03-key"
}

variable "azs" {
  description = "The available zone of ap-norheast-2"
  type        = list(string)
  default     = ["ap-northeast-2a", "ap-northeast-2c"]
}
