variable "namespace" {}
variable "chart_repository" {}
variable "username" {}
variable "database" {}
variable "postgres_password" {}

resource "helm_release" "postgresql" {
  name       = "postgresql"
  repository = var.chart_repository
  chart      = "postgresql"
  namespace  = var.namespace

  set {
    name  = "auth.postgresPassword"
    value = var.postgres_password
  }

  set {
    name  = "auth.enablePostgresUser"
    value = "true"
  }

  set {
    name  = "auth.username"
    value = var.username
  }

  set {
    name  = "auth.password"
    value = var.postgres_password
  }

  set {
    name  = "auth.database"
    value = var.database
  }
}

output "release_name" {
  value = helm_release.postgresql.name
}
