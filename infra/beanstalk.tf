resource "aws_elastic_beanstalk_application" "application" {
  name        = var.repo_name
  description = var.repo_description

  #   appversion_lifecycle {
  #     service_role          = aws_iam_role.beanstalk.arn
  #     max_count             = 128
  #     delete_source_from_s3 = true
  #   }
}

resource "aws_elastic_beanstalk_environment" "application" {
  name                = var.env
  application         = aws_elastic_beanstalk_application.application.name
  solution_stack_name = "64bit Amazon Linux 2023 v4.1.1 running Docker"

  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "InstanceType"
    value     = var.instance_type
  }

  setting {
    namespace = "aws:autoscaling:asg"
    name      = "MaxSize"
    value     = var.max_size
  }

  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "IamInstanceProfile"
    value     = aws_iam_instance_profile.beanstalk.name
  }
}

resource "aws_elastic_beanstalk_application_version" "default" {
  depends_on = [
    aws_elastic_beanstalk_application.application,
    aws_elastic_beanstalk_environment.application,
    aws_s3_bucket_object.docker
  ]

  name        = var.env
  application = var.repo_name
  description = var.repo_description
  bucket      = aws_s3_bucket.deploy.id
  key         = aws_s3_bucket_object.docker.id
}