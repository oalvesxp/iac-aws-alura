resource "aws_ecr_repository" "this" {
  name         = var.repo_name
  force_delete = true
}