module "aws_dev" {
  source = "../../infra"
  regiao_aws = "us-east-1"
  instancia = "t2.micro"
  chave = "dev-key"
  sg_name = "grupo-dev"
  env_name = "Development"
  name = "dev"

  nomeGrupo = "autoScalingDev"
  minimo = 0
  maximo = 3
}

output "ip" {
  value = module.aws_dev.ip_publico
}