variable "vpc_cidr" {
    default = "10.3.0.0/16"
}
variable "public_subnet" {
    type = list
    default = ["10.3.0.0/20", "10.3.16.0/20"]
}
variable "private_subnet" {
    type = list
    default = ["10.3.64.0/20", "10.3.80.0/20"]
}
variable "azs" {
    type = list
    default = ["ap-northeast-2a", "ap-northeast-2c"]
}