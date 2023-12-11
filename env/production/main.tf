module "production" {
  source = "../../infra"

  repo_name        = "production"
  repo_description = "application-of-production"
  env              = "env-production"
  instance_type    = "t2.micro"
  max_size         = 5
}