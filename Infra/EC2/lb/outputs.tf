output "alb_dns_name" {
  value       = aws_lb.project03-lb.dns_name
  description = "The domain name of the load balancer"
}

output "load_balancer_arn" {
  value       = aws_lb.project03-lb.arn
  description = "The arn of the loadbalancer"
}

# Target
output "target_group_petclinic_arn" {
  value       = aws_lb_target_group.project03-target-group-petclinic.arn
  description = "The arn of the petclinic target group"
}
output "target_group_petclinic_id" {
  value       = aws_lb_target_group.project03-target-group-petclinic.id
  description = "The id of the petclinic target group"
}

# Jenkins
output "target_group_jenkins_arn" {
  value       = aws_lb_target_group.project03-target-group-jenkins.arn
  description = "The arn of the jenkins target group"
}
output "target_group_jenkins_id" {
  value       = aws_lb_target_group.project03-target-group-jenkins.id
  description = "The id of the jenkins target group"
}

# Listener
output "aws_lb_listener_arn_HTTP" {
  value       = aws_lb_listener.http.arn
  description = "The HTTP arn of the listener"
}
output "aws_lb_listener_arn_HTTPS" {
  value       = aws_lb_listener.https.arn
  description = "The HTTPS arn of the listener"
}
output "aws_lb_listener_arn_WEB" {
  value       = aws_lb_listener.web.arn
  description = "The WEB arn of the listener"
}
