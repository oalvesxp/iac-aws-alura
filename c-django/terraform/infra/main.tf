terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region  = var.regiao_aws
  profile = "tf-demo-aws"
}

# resource "aws_instance" "app_server" {
#   ami           = "ami-0fc5d935ebf8bc3bc"
#   instance_type = var.instancia
#   key_name = var.chave
#   tags = {
#     Name = "vm-${var.name}-app00"
#     Env = "dev"
#   }
# }

resource "aws_launch_template" "maquina" {
  image_id        = "ami-0fc5d935ebf8bc3bc"
  instance_type   = var.instancia
  key_name        = var.chave
  
  tags = {
    Name  = "vm-${var.name}-app00"
    Env   = var.name
  }

  security_group_names = [ var.sg_name ]
  user_data = filebase64("playbook-prod-setup.sh")
}

resource "aws_key_pair" "chaveSSH" {
  key_name = var.chave
  public_key = file("${var.chave}.pub")
}

# output "ip_publico" {
#   value = aws_instance.app_server.public_ip
# }

resource "aws_autoscaling_group" "grupo" {
  availability_zones = [ "${var.regiao_aws}a" ]
  name = var.nomeGrupo
  max_size = var.maximo
  min_size = var.minimo
  launch_template {
    id = aws_launch_template.maquina.id
    version = "$Latest"
  }
}