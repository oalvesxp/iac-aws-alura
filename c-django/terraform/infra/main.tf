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
  availability_zones = [ "${var.regiao_aws}a", "${var.regiao_aws}b" ]
  name = var.nomeGrupo
  max_size = var.maximo
  min_size = var.minimo
  launch_template {
    id = aws_launch_template.maquina.id
    version = "$Latest"
  }
  target_group_arns = [ aws_lb_target_group.grupoLB.arn ]
}

resource "aws_default_subnet" "subnet_1" {
  availability_zone = "${var.regiao_aws}a"
}

resource "aws_default_subnet" "subnet_2" {
  availability_zone = "${var.regiao_aws}b"
}

resource "aws_lb" "loadBalancer" {
  internal = false
  subnets = [ aws_default_subnet.subnet_1.id, aws_default_subnet.subnet_2.id ]
}

resource "aws_default_vpc" "default" {
  
}

resource "aws_lb_target_group" "grupoLB" {
  name = "grupoLB"
  port = "8000"
  protocol = "HTTP"
  vpc_id = aws_default_vpc.default.id
}

resource "aws_lb_listener" "entradaLB" {
  load_balancer_arn = aws_lb.loadBalancer.arn
  port = "8000"
  protocol = "HTTP"
  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.grupoLB.arn
  }
}