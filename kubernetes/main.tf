## Configurando as informações do provider
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.31.0"
    }
  }

  required_version = ">= 1.2.0"
}

## Importando módulos
module "backend" {
  source = "./modules/backend"
}

module "network" {
  source  = "./modules/vpc"
}