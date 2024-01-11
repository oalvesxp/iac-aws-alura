module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  name   = "vpc-eks"
  cidr   = "10.0.0.0/16"

  azs                = [var.availability_zones[0], var.availability_zones[1], var.availability_zones[2]]
  private_subnets    = [var.private_subnets[0], var.private_subnets[1], var.private_subnets[2]]
  public_subnets     = [var.public_subnets[0], var.public_subnets[1], var.public_subnets[2]]
  enable_nat_gateway = true
}