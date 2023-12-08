
resource "aws_elastic_beanstalk_application" "ElbApp" {
  name        = "my-eb-app"
  description = "My Elastic Beanstalk Application"
}

resource "aws_elastic_beanstalk_environment" "ElbEnv" {
  name                = "ElasticBeanstalkEnvironment"
  application         = aws_elastic_beanstalk_application.ElbApp.name
  solution_stack_name = "64bit Amazon Linux 2 v5.8.8 running Node.js 18"

  #   setting {
  #     namespace = "aws:autoscaling:launchconfiguration"
  #     name      = "IamInstanceProfile"
  #     value     = aws_iam_role.ElbRole.name
  #   }
  #   setting {
  #     namespace = "aws:autoscaling:launchconfiguration"
  #     name      = "IamInstanceProfile"
  #     value     = "AWSServiceRoleForElasticBeanstalk"
  #   }
  #   setting {
  #     namespace = "aws:autoscaling:launchconfiguration"
  #     name      = "InstanceType"
  #     value     = "t2.micro"
  #   }

  ####################
  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "IamInstanceProfile"
    value     = "aws-elasticbeanstalk-ec2-role"
  }
  setting {
    namespace = "aws:ec2:vpc"
    name      = "AssociatePublicIpAddress"
    value     = "True"
  }

}

resource "aws_elb" "DemoElb" {
  name               = "Demo-Elb"
  availability_zones = var.availability_zones
  listener {
    instance_port     = 80
    instance_protocol = "HTTP"
    lb_port           = 80
    lb_protocol       = "HTTP"
  }
}

resource "aws_launch_configuration" "MyLaunchConfig" {
  name          = "MyLaunchConfigNew"
  image_id      = var.image_id
  instance_type = "t2.micro"

  #   iam_instance_profile = aws_iam_role.ElbRole.name
  iam_instance_profile = "aws-elasticbeanstalk-ec2-role"

  security_groups = ["sg-0f7f3772a6441c4ac"]

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "my_asg" {
  desired_capacity     = 2
  max_size             = 4
  min_size             = 2
  vpc_zone_identifier  = var.vpc_zone_identifiers
  launch_configuration = aws_launch_configuration.MyLaunchConfig.id

  tag {
    key                 = "Name"
    value               = "my-asg-instance"
    propagate_at_launch = true
  }

  health_check_type         = "EC2"
  health_check_grace_period = 300

}

resource "aws_cloudwatch_metric_alarm" "scale_out_alarm" {
  alarm_name          = "scale-out-alarm"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 5
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 300
  statistic           = "Average"
  threshold           = 80
  alarm_description   = "Scale out if CPU utilization is greater than 80% for 5 consecutive periods."

  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.my_asg.name
  }

  alarm_actions = [aws_autoscaling_policy.scale_out_policy.arn]
}

resource "aws_cloudwatch_metric_alarm" "scale_in_alarm" {
  alarm_name          = "scale-in-alarm"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = 10
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 300
  statistic           = "Average"
  threshold           = 30
  alarm_description   = "Scale in if CPU utilization is less than 30% for 10 consecutive periods."

  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.my_asg.name
  }

  alarm_actions = [aws_autoscaling_policy.scale_in_policy.arn]
}

resource "aws_autoscaling_policy" "scale_out_policy" {
  name                   = "scale-out-policy"
  scaling_adjustment     = 1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  policy_type            = "SimpleScaling"
  autoscaling_group_name = aws_autoscaling_group.my_asg.name
}
resource "aws_autoscaling_policy" "scale_in_policy" {
  name                   = "scale-in-policy"
  scaling_adjustment     = -1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 600
  policy_type            = "SimpleScaling"
  autoscaling_group_name = aws_autoscaling_group.my_asg.name
}

# resource "aws_elastic_beanstalk_environment" "tag" {
#   name        = aws_elastic_beanstalk_application.ElbApp.name
#   application = aws_elastic_beanstalk_application.ElbApp.name

#   tags = var.tags
# }