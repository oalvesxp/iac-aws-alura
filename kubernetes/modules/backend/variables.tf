## Variáveis para o Backend remoto
variable "bucket_name" {
  description = "Nome do bucket de Backend externo"
  type        = string
  default     = "tf-state-831511089306-us-east-1"
}

variable "table_name" {
  description = "Nome da tabela para lock externo"
  type        = string
  default     = "locking-831511089306-us-east-1"
}