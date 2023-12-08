output "elb_dns_name" {
  description = "The DNS name of the Elastic Load Balancer."
  value       = aws_elb.DemoElb.dns_name
}

output "asg_name" {
  description = "The name of the Auto Scaling Group."
  value       = aws_autoscaling_group.my_asg.name
}
