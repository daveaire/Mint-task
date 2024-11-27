variable "namespace" {
  description = "Namespace for the PostgreSQL deployment"
  type        = string
}

variable "chart_repository" {
  description = "Helm chart repository for PostgreSQL"
  type        = string
}

variable "chart_version" {
  description = "Helm chart version for PostgreSQL"
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
  description = "Secure password for PostgreSQL"
  type        = string
}
