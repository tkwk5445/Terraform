output "vpc_id" {
  value = aws_vpc.project03_vpc.id
}

# output "public_subnet_arns" {
#    value = aws_vpc.project03_public_subnet_arns
# }

output "public_subnet2a" {
  value = aws_subnet.project03_subnet_public1_ap_northeast_2a.id
}
output "public_subnet2c" {
  value = aws_subnet.project03_subnet_public1_ap_northeast_2c.id
}
output "private_subnet2a" {
  value = aws_subnet.project03_subnet_private1_ap_northeast_2a.id
}
output "private_subnet2c" {
  value = aws_subnet.project03_subnet_private1_ap_northeast_2c.id
}