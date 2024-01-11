## Criando o repositório no AWS ECR
resource "aws_ecr_repository" "this" {
  name = var.ecr_repo_name
}