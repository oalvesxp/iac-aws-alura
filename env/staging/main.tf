module "production" {
  source = "../../infra"

  repo_name        = "staging"
  repo_description = "application-of-staging"
  env              = "env-staging"
  instance_type    = "t2.micro"
  max_size         = 5
}