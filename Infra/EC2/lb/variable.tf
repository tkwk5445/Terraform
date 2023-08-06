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

variable "remote_state_jenkins_instance" {
  description = "The key of the remote state file for Jenkins instance in the S3 bucket."
  default     = "project03/Infra/EC2/Instance/Jenkins/terraform.tfstate"
}

variable "remote_state_asg" {
  description = "The key of the remote state file for the Auto Scaling Group in the S3 bucket."
  default     = "project03/Infra/EC2/ASG/terraform.tfstate"
}
variable "remote_state_region" {
  description = "The AWS region where the S3 bucket storing the remote state is located."
  default     = "ap-northeast-2"
}
