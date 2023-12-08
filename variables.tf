variable "aws_region" {
  type    = string
  default = "us-east-1"
}

variable "image_id" {
  type = string
}

variable "vpc_id" {
  description = "The ID of the existing VPC where the resources will be created."
}

variable "tags" {
  description = "A map of tags to apply to the resources created."
  type        = map(string)
}

variable "availability_zones" {
  description = "A list of availability zones for the Elastic Load Balancer."
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b"]
}

variable "vpc_zone_identifiers" {
  description = "A list of subnet IDs for the Auto Scaling Group."
  type        = list(string)
}