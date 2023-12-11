terraform {
  ################################################################
  ## Assumes S3 bucket and dynamo DB table already set up
  ## See ../../infra/bakend.tf
  ################################################################
  backend "s3" {
    bucket         = "tf-demo-831511089306-us-east-1"
    key            = "tf-prod/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-state-locking"
    encrypt        = true
  }
}
