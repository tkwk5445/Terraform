output "vpc_id" {
  value = aws_vpc.project03_vpc.id
}

output "public_subnet2a" {
  value = aws_subnet.public[0].id
}

output "public_subnet2c" {
  value = aws_subnet.public[1].id
}

output "private_subnet2a" {
  value = aws_subnet.private[0].id
}

output "private_subnet2c" {
  value = aws_subnet.private[1].id
}

output "eip_id" {
  value = aws_eip.project03_eip.id
}

output "eip_ip" {
  value = aws_eip.project03_eip.public_ip
}
