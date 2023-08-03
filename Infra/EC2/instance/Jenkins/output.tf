output "jenkins-EC2" {
  value = aws_instance.project03-jenkins-ec2.id
}

output "jenkins-EC2-arn" {
  value = aws_instance.project03-jenkins-ec2.arn
}
