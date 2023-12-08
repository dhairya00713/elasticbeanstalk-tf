output "elastic_beanstalk_application_name" {
  value       = aws_elastic_beanstalk_application.elasticapp.name
  description = "Elastic Beanstalk Application name"
}