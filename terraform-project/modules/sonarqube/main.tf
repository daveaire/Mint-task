variable "namespace" {}
variable "postgresql_enabled" {}
variable "postgresql_server" {}
variable "postgresql_username" {}
variable "postgresql_password" {}
variable "postgresql_database" {}

resource "helm_release" "sonarqube" {
  name      = "sonarqube"
  chart     = "oteemocharts/sonarqube"
  namespace = var.namespace

  set {
    name  = "postgresql.enabled"
    value = var.postgresql_enabled
  }

  set {
    name  = "postgresql.postgresqlServer"
    value = var.postgresql_server
  }

  set {
    name  = "postgresql.postgresqlUsername"
    value = var.postgresql_username
  }

  set {
    name  = "postgresql.postgresqlPassword"
    value = var.postgresql_password
  }

  set {
    name  = "postgresql.postgresqlDatabase"
    value = var.postgresql_database
  }

  set {
    name  = "persistence.enabled"
    value = "true"
  }
}

output "release_name" {
  value = helm_release.sonarqube.name
}
