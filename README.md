
# Automation Script for Setting Up Minikube, Helm, Terraform, and Deploying SonarQube

This script automates the setup of a Minikube cluster and deploys SonarQube with PostgreSQL using Terraform and Kubernetes.

---

## Features


1. **Minikube Configuration**:
   - Configures Minikube with:
     - 4 CPUs
     - 7949GB memory
     - Docker driver
   - Starts Minikube and enables the ingress addon.

2. **Helm Repository Setup**:
   - Adds the Oteemo Helm chart repository for SonarQube.

3. **Terraform Deployment**:
   - Deploys PostgreSQL and SonarQube.

4. **Ingress Configuration and Verification**:
   - Applies an `ingress.yaml` file to expose SonarQube.
   - Verifies application accessibility via `curl`.

---

This script automates the setup of Minikube and deployment of applications using Terraform. It assumes all dependencies are pre-installed.

---

## Prerequisites

Before running the script, ensure the following dependencies are installed:

1. **Docker**:
   - [Install Docker](https://docs.docker.com/engine/install/)

2. **Minikube**:
   - [Install Minikube](https://minikube.sigs.k8s.io/docs/start/)

3. **kubectl**:
   - [Install kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/)

4. **Helm**:
   - [Install Helm](https://helm.sh/docs/intro/install/)

5. **Terraform**:
   - [Install Terraform](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)



- **Operating System**: Debian-based Linux.
- **Terraform Project Folder**: A folder named `terraform-project` containing Terraform files.
- **Ingress YAML**: An `ingress.yaml` file for SonarQube.
# Automation Script for Minikube and Terraform Deployment

---


## Important Notes

- **Add User to Docker Group**:
   After installing Docker, ensure your user is added to the `docker` group:
   ```bash
   sudo usermod -aG docker $USER
   ```
   You must log out and log back in or run:
   ```bash
   newgrp docker
   ```
   to apply the changes.

- **Minikube Requires Docker**:
   Ensure Docker is running before starting Minikube.

---

## Usage

### Step 1: Download the Script

```bash
   git clone <repository-url>
   cd <repository-folder>
   ```

### Step 2: Make the Script Executable
```bash
chmod +x setup.sh
```

### Step 3: Run the Script
Run the script with root privileges:
```bash
 ./setup.sh
```

---

## Script Workflow

1. **Configure and Start Minikube**:
   - Allocates 4 CPUs and 7949B memory for Minikube.
   - Sets Docker as the driver.
   - Enables the Minikube ingress addon.

2. **Add Helm Repository**:
   - Adds the Oteemo Helm chart repository.

3. **Terraform Deployment**:
   - Initializes and applies the Terraform configuration in the `terraform-project` folder.

4. **Ingress Configuration**:
   - Applies the `ingress.yaml` file to expose SonarQube.

5. **Verify Application**:
   - Retrieves the Minikube IP.
   - Verifies SonarQube is accessible via HTTP using `curl`.

---

## Example Output

```bash
Starting the automation script...
Configuring Minikube...
Starting Minikube...
Enabling ingress addon...
Adding Helm repository...
Navigating to Terraform folder...
Initializing Terraform...
Applying Terraform configuration...
Applying ingress.yaml...
Minikube IP: 192.168.49.2
Verifying SonarQube application...
HTTP/1.1 200 OK
Automation script completed successfully!
```

---

## Notes

- **Resource Allocation**: Ensure your system has sufficient resources to allocate 4 CPUs and GB of memory to Minikube.
- **Minikube Driver**: The script uses Docker as the Minikube driver. Ensure Docker is installed and running.
- **Terraform Files**: The `terraform-project` folder must contain valid Terraform configurations for PostgreSQL and SonarQube.

---

## Troubleshooting

1. **Minikube Not Starting**:
   - Verify Docker is running.
   - Check virtualization settings on your machine.

2. **Terraform Errors**:
   - Ensure valid configurations in the `terraform-project` folder.
   - Run `terraform validate` for debugging.

3. **Ingress Issues**:
   - Verify the ingress addon is enabled using:
     ```bash
     minikube addons list
     ```

4. **Application Not Accessible**:
   - Confirm the Minikube IP using:
     ```bash
     minikube ip
     ```
   - Check Kubernetes resources:
     ```bash
     kubectl get all -n <namespace>
     ```

---

## License

This script is provided as-is, without warranty. Use it at your own risk.

