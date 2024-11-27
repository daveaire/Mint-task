resource "helm_release" "sonarqube" {
  name       = "sonarqube"
  namespace  = var.namespace
  repository = "oteemocharts/sonarqube"
  chart      = "sonarqube"

  set {
    name  = "postgresql.enabled"
    value = "false"
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
