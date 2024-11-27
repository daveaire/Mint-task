variable "namespace" {
  description = "Namespace for the SonarQube release"
  type        = string
}

variable "postgresql_enabled" {
  description = "Enable embedded PostgreSQL for SonarQube"
  type        = bool
}

variable "postgresql_server" {
  description = "PostgreSQL server address"
  type        = string
}

variable "postgresql_username" {
  description = "PostgreSQL username for SonarQube"
  type        = string
}

variable "postgresql_password" {
  description = "PostgreSQL password for SonarQube"
  type        = string
  sensitive   = true
}

variable "postgresql_database" {
  description = "PostgreSQL database for SonarQube"
  type        = string
}
