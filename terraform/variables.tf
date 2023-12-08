variable "elasticapp" {
  default = "ElasticApp"
}
variable "beanstalkappenv" {
  default = "Production"
}
variable "solution_stack_name" {
  type = string
}
variable "tier" {
  type = string
}

variable "vpc_id" {}
variable "public_subnets" {}
variable "elb_public_subnets" {}
variable "tags" {
  description = "A map of tags to apply to the resources created."
  type        = map(string)
}
