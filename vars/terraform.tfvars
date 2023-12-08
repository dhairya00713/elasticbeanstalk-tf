vpc_id = "vpc-014e709a5058ba9a8"
# Instance_type       = "t2.medium"
# minsize             = 1
# maxsize             = 2
public_subnets      = ["subnet-0422494bfcb1d16e3", "subnet-03eb603acefa34cca"] # Service Subnet
elb_public_subnets  = ["subnet-0422494bfcb1d16e3", "subnet-03eb603acefa34cca"] # ELB Subnet
tier                = "WebServer"
solution_stack_name = "64bit Amazon Linux 2 v5.8.8 running Node.js 18"

tags = {
  Name        = "MyApp"
  Environment = "Production"
  Project     = "MyProject"
  Purpose     = "WebServer"
  CreatedBy   = "Terraform"
}