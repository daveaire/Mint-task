# Providers
provider "kubernetes" {
  config_path = "~/.kube/config"
}

provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
}

provider "random" {}

# Generate a secure password for PostgreSQL
resource "random_password" "postgres" {
  length  = 16
  special = true
}

# PostgreSQL Module
module "postgresql" {
  source                = "./modules/postgresql"
  namespace             = "default"
  chart_repository      = "oci://registry-1.docker.io/bitnamicharts"
  username              = "sonarUser"
  database              = "sonarDB"
  postgres_password     = random_password.postgres.result
}

# SonarQube Module
module "sonarqube" {
  source                       = "./modules/sonarqube"
  namespace                    = "default"
  postgresql_enabled           = false
  postgresql_server            = "${module.postgresql.release_name}.default.svc.cluster.local"
  postgresql_username          = "sonarUser"
  postgresql_password          = module.postgresql.postgres_password
  postgresql_database          = "sonarDB"

  depends_on = [
    module.postgresql
  ]
}
