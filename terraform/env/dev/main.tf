module "aws_dev" {
  source = "../../infra"
  instance = "t2.micro"
  region_aws = "us-east-1"
  key_ssh = "dev-key"
}