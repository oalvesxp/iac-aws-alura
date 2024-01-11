## Configurando as informações do provider
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

## Importando o módulo de backend externo
module "backend" {
  source = "./modules/backend"
}