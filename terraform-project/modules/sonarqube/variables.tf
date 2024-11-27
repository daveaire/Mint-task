variable "namespace" {
  description = "Namespace for the SonarQube deployment"
  type        = string
}

variable "postgresql_enabled" {
  description = "Flag to enable or disable embedded PostgreSQL"
  type        = bool
}

variable "postgresql_server" {
  description = "PostgreSQL server FQDN"
  type        = string
}

variable "postgresql_username" {
  description = "PostgreSQL username for SonarQube"
  type        = string
}

variable "postgresql_password" {
  description = "PostgreSQL password for SonarQube"
  type        = string
}

variable "postgresql_database" {
  description = "PostgreSQL database for SonarQube"
  type        = string
}
