resource "aws_security_group" "grupo-dev" {
  name = "grupo-dev"
  description = "Grupo de segurança para o time de Dev."
  
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
    Name = "group-dev"
  }
}