output "jenkins-EC2" {
  value = aws_instance.project03-jenkins-ec2.id
}

data "aws_iam_role" "target" {
  name = "project03-codedeploy-ec2-role"
}
