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
  region  = var.region_aws
  profile = "tf-demo-aws"
}

resource "aws_instance" "app_server" {
  ami           = "ami-0fc5d935ebf8bc3bc"
  instance_type = var.instance
  key_name = var.key_ssh
  tags = {
    Name = "vm-django"
    OS = "ubuntu"
  }
}

resource "aws_key_pair" "chaveSSH" {
  key_name = var.key_ssh
  public_key = file("${var.key_ssh}.pub")
}