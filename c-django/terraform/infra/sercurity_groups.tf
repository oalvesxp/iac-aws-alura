resource "aws_security_group" "grupo-seguranca" {
  name = var.sg_name
  description = "Grupo de ${var.env_name}"
  
  ingress{
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
    from_port = 0
    to_port = 0
    protocol = "-1"
  }

  egress{
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
    from_port = 0
    to_port = 0
    protocol = "-1"
  }
  
  tags = {
    Name = var.sg_name
  }
}