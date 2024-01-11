## Variáveis da VPC
variable "availability_zones" {
  description = "us-east-1 AZs"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b", "us-east-1c"]
}

variable "private_subnets" {
  description = "Lista de subnets privadas"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}

variable "public_subnets" {
  description = "Lista de subnets privadas"
  type        = list(string)
  default     = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
}

## Variáveis para o repositório ECR
variable "ecr_repo_name" {
  description = "Nome do repositório ECR"
  type        = string
}

## Variáveis para o EKS
variable "cluster_name" {
  description = "Nome do Cluster EKS"
  type        = string
  default     = "api-eks-cluster"
}