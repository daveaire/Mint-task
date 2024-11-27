variable "namespace" {
  description = "Namespace for the deployments"
  type        = string
  default     = "default"
}

variable "postgresql_chart_repository" {
  description = "Repository for the PostgreSQL Helm chart"
  type        = string
  default     = "oci://registry-1.docker.io/bitnamicharts"
}

variable "postgresql_chart_version" {
  description = "Version of the PostgreSQL Helm chart"
  type        = string
  default     = "12.1.1"
}

variable "postgresql_username" {
  description = "PostgreSQL username"
  type        = string
  default     = "sonarUser"
}

variable "postgresql_database" {
  description = "PostgreSQL database name"
  type        = string
  default     = "sonarDB"
}
