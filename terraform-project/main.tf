provider "kubernetes" {
  config_path = "~/.kube/config"
}

provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
}

provider "random" {}

# PostgreSQL Deployment
module "postgresql" {
  source            = "./modules/postgresql"
  namespace         = var.namespace
  chart_repository  = var.postgresql_chart_repository
  chart_version     = var.postgresql_chart_version
  username          = var.postgresql_username
  database          = var.postgresql_database
  postgres_password = random_password.postgres.result
}

# SonarQube Deployment
module "sonarqube" {
  source                = "./modules/sonarqube"
  namespace             = var.namespace
  postgresql_enabled    = false
  postgresql_server     = "${module.postgresql.release_name}.${var.namespace}.svc.cluster.local"
  postgresql_username   = var.postgresql_username
  postgresql_password   = random_password.postgres.result
  postgresql_database   = var.postgresql_database

  depends_on = [module.postgresql]
}

resource "random_password" "postgres" {
  length  = 16
  special = true
}

output "postgresql_release_name" {
  value = module.postgresql.release_name
}

output "sonarqube_release_name" {
  value = module.sonarqube.release_name
}

output "postgresql_password" {
  value       = random_password.postgres.result
  sensitive   = true
}
