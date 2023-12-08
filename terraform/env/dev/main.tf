module "aws_dev" {
  source = "../../infra"
  regiao_aws = "us-east-1"
  instancia = "t2.micro"
  chave = "dev-key"
  sg_name = "grupo-prod"
}

output "ip" {
  value = module.aws_dev.ip_publico
}