variable "namespace" {
  description = "Namespace for the PostgreSQL release"
  type        = string
}

variable "chart_repository" {
  description = "Repository for the PostgreSQL Helm chart"
  type        = string
}

variable "username" {
  description = "PostgreSQL username"
  type        = string
}

variable "database" {
  description = "PostgreSQL database name"
  type        = string
}

variable "postgres_password" {
  description = "PostgreSQL password"
  type        = string
  sensitive   = true
}
