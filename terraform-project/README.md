
# Terraform Kubernetes Deployment for PostgreSQL and SonarQube

This project provides a modular and secure Terraform configuration to deploy PostgreSQL and SonarQube on a Kubernetes cluster using Helm charts. It incorporates best practices such as modularization, secure password management, and explicit dependency handling.

---

## System Requirements

Ensure your system meets the following requirements:

- **Operating System**: Linux (Debian/Ubuntu preferred)
- **RAM**: 8GB or more
- **Disk Space**: At least 20GB of free disk space
- **CPU**: 4 cores minimum
- **Internet**: Active internet connection for downloading dependencies and charts


---

## **Prerequisites**

1. A Kubernetes cluster (e.g., Minikube, AKS, EKS, GKE, or other).
2. `kubectl` configured to connect to your cluster.
3. Helm installed on your system.
4. Terraform v1.5 or newer.
5. A Kubernetes config file available (e.g., `~/.kube/config`).

---

## **Folder Structure**

The project is organized as follows:

```
terraform-project/
├── main.tf                 # Main Terraform configuration
├── variables.tf            # Global variables for the project
├── modules/                # Modules directory
│   ├── postgresql/         # PostgreSQL module
│   │   ├── main.tf         # Main PostgreSQL configuration
│   │   ├── variables.tf    # Variables for PostgreSQL   
│   ├── sonarqube/          # SonarQube module
│       ├── main.tf         # Main SonarQube configuration
│       ├── variables.tf    # Variables for SonarQube
└── README.md               # Documentation
```

---

## **Features**

1. **Modular Design**:
   - Separate modules for PostgreSQL and SonarQube deployments.
   - Easy to reuse and adapt for other environments.

2. **Secure Password Management**:
   - Passwords for PostgreSQL are generated securely using the `random_password` resource from Terraform's Random provider.

3. **Explicit Dependencies**:
   - Ensures SonarQube waits for PostgreSQL to be deployed successfully using the `depends_on` argument.

4. **Customizable**:
   - Allows configuration of namespaces, Helm chart versions, and repositories via variables.

5. **Kubernetes DNS Integration**:
   - Dynamically constructs the FQDN for PostgreSQL using Kubernetes conventions.

---

## **How to Use**

### 1. Clone the Repository
```bash
git clone <repository-url>
cd terraform-project
```

### 2. Set Up Environment-Specific Variables
Edit the `terraform.tfvars` file to customize your configuration. Example:
```hcl
namespace = "default"
```

### 3. Initialize Terraform
```bash
terraform init
```

### 4. Plan the Deployment
Review the resources that Terraform will create:
```bash
terraform plan
```

### 5. Apply the Configuration
Deploy PostgreSQL and SonarQube:
```bash
terraform apply
```

### 6. Verify the Deployment
- Check the resources in the Kubernetes cluster:
  ```bash
  kubectl get all -n <namespace>
  ```
- Retrieve the generated PostgreSQL password:
  ```bash
  terraform output postgresql_password
  ```

---

## **Modules**

### PostgreSQL Module (`modules/postgresql`)
Deploys a PostgreSQL database using the Bitnami Helm chart.

**Inputs**:
- `namespace`: Namespace for the PostgreSQL release.
- `chart_repository`: Helm chart repository.
- `chart_version`: Helm chart version.
- `username`: PostgreSQL username.
- `database`: PostgreSQL database name.
- `postgres_password`: Secure password for PostgreSQL.

**Outputs**:
- `release_name`: Name of the PostgreSQL Helm release.

---

### SonarQube Module (`modules/sonarqube`)
Deploys SonarQube using the Oteemo Helm chart and connects it to PostgreSQL.

**Inputs**:
- `namespace`: Namespace for the SonarQube release.
- `chart_repository`: Helm chart repository.
- `chart_version`: Helm chart version.
- `postgresql_enabled`: Whether to use embedded PostgreSQL.
- `postgresql_server`: FQDN of the PostgreSQL server.
- `postgresql_username`: PostgreSQL username for SonarQube.
- `postgresql_password`: PostgreSQL password for SonarQube.
- `postgresql_database`: PostgreSQL database for SonarQube.

**Outputs**:
- `release_name`: Name of the SonarQube Helm release.

---

## **Configuration Variables**

| Variable                  | Description                                    | Default Value                           |
|---------------------------|------------------------------------------------|-----------------------------------------|
| `namespace`               | Namespace for deployments                     | `default`                               |
| `config_path`             | Path to Kubernetes config file                | `~/.kube/config`                        |
| `postgresql_chart_repository` | PostgreSQL Helm chart repository           | `oci://registry-1.docker.io/bitnamicharts` |
| `postgresql_chart_version` | PostgreSQL Helm chart version                | `12.1.1`                                |
| `sonarqube_chart_repository` | SonarQube Helm chart repository            | `oteemocharts/sonarqube`                |
| `sonarqube_chart_version` | SonarQube Helm chart version                  | `0.2.0`                                 |
| `postgresql_username`     | PostgreSQL username                           | `sonarUser`                             |
| `postgresql_database`     | PostgreSQL database name                      | `sonarDB`                               |

---

## **Outputs**

| Output Name             | Description                                            |
|-------------------------|--------------------------------------------------------|
| `postgresql_release_name` | Name of the PostgreSQL Helm release                 |
| `sonarqube_release_name` | Name of the SonarQube Helm release                   |
| `postgresql_password`   | Generated secure password for PostgreSQL (sensitive) |

---

## **Security Considerations**

1. **Passwords**:
   - Passwords are generated securely and marked as sensitive to prevent exposure.
   - Avoid hardcoding sensitive data in `terraform.tfvars` or other configuration files.

2. **Namespace**:
   - Use unique namespaces for deployments in shared clusters to avoid conflicts.

3. **Helm Chart Versions**:
   - Lock chart versions to prevent unintended upgrades during re-application.

---

## **Troubleshooting**

1. **Deployment Errors**:
   - Ensure `kubectl` is configured to point to the correct cluster.
   - Verify the Helm repositories are accessible.

2. **Password Not Displayed**:
   - Use `terraform output -json postgresql_password` to retrieve sensitive outputs.

3. **DNS Issues**:
   - Verify the FQDN for PostgreSQL matches your Kubernetes DNS settings.

---

## **Future Improvements**

1. **Support for Multiple Environments**:
   - Add workspace support for staging, production, etc.

2. **Monitoring**:
   - Include monitoring tools like Prometheus and Grafana.

3. **Scaling**:
   - Configure resource limits and replicas for PostgreSQL and SonarQube.

---

This README provides a comprehensive overview of the project, ensuring clarity and ease of use for all levels of Terraform users.
