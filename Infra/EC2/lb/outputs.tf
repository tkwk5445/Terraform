output "alb_dns_name" {
  value       = aws_lb.project03-lb.dns_name
  description = "The domain name of the load balancer"
}

output "target_group_arn" {
  value       = aws_lb_target_group.project03-target-group.arn
  description = "The arn of the target group arn"
}

output "target_group_id" {
  value       = aws_lb_target_group.project03-target-group.id
  description = "The arn of the target group id"
}

output "load_balancer_arn" {
  value       = aws_lb.project03-lb.arn
  description = "The arn of the target group"
}

output "aws_lb_listener_arn_HTTP" {
  value       = aws_lb_listener.http.arn
  description = "The HTTP arn of the target group"
}
