variable "vpc_cidr" {
  description = "The cidr of vpc"
  default     = "10.3.0.0/16"
}

variable "public_subnet" {
  description = "The public subnet of vpc"
  type        = list(string)
  default     = ["10.3.0.0/20", "10.3.16.0/20"]
}

variable "private_subnet" {
  description = "The private subnet of vpc"
  type        = list(string)
  default     = ["10.3.64.0/20", "10.3.80.0/20"]
}

variable "azs" {
  description = "The available zone of ap-northeast-2"
  type        = list(string)
  default     = ["ap-northeast-2a", "ap-northeast-2c"]
}

