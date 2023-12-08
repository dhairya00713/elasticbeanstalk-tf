aws_region = "us-east-1"
vpc_id     = "vpc-014e709a5058ba9a8"
image_id   = "ami-0230bd60aa48260c6" #Amazon Linux 2 AMI 2023
tags = {
  Name        = "MyApp"
  Environment = "Production"
  Project     = "MyProject"
  Purpose     = "WebServer"
  CreatedBy   = "Terraform"
}
availability_zones   = ["us-east-1a", "us-east-1b"]
vpc_zone_identifiers = ["subnet-0422494bfcb1d16e3", "subnet-03eb603acefa34cca"]
