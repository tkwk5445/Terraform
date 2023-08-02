output "target-ami" {
  value = aws_ami_from_instance.project03-target.id
}
