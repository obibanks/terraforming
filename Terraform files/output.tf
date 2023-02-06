output "aws_instance_public_dns" {
  value       = aws_lb.apache.dns_name
  description = "DNS for Load Balancer"
}
