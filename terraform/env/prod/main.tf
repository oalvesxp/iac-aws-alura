module "aws_prod" {
  source = "../../infra"
  instancia = "t2.micro"
  regiao_aws = "us-east-1"
  chave = "prod-key"
}

output "IP" {
  value = module.aws_prod.ip_publico
}
