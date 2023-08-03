data "aws_instances" "project03-GROUP" {
  instance_tags = {
    Name = "project03-GROUP"
  }
}
