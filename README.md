
# Automation Script for Setting Up Minikube, Helm, Terraform, and Deploying SonarQube

This script automates the setup of a Minikube cluster, installs necessary dependencies, and deploys SonarQube with PostgreSQL using Terraform and Kubernetes.

---

## Features

1. **Automated Dependency Installation**:
   - Installs Docker, Minikube, Helm, kubectl, and Terraform.

2. **Minikube Configuration**:
   - Configures Minikube with:
     - 2 CPUs
     - 4GB memory
     - Docker driver
   - Starts Minikube and enables the ingress addon.

3. **Helm Repository Setup**:
   - Adds the Oteemo Helm chart repository for SonarQube.

4. **Terraform Deployment**:
   - Deploys PostgreSQL and SonarQube.

5. **Ingress Configuration and Verification**:
   - Applies an `ingress.yaml` file to expose SonarQube.
   - Verifies application accessibility via `curl`.

---

## Prerequisites

- **Operating System**: Debian-based Linux.
- **Terraform Project Folder**: A folder named `terraform-project` containing Terraform files.
- **Ingress YAML**: An `ingress.yaml` file for SonarQube.

---

## Usage

### Step 1: Download the Script

Save the script locally or download it:
```bash
wget <script-download-link> -O setup.sh
```

### Step 2: Make the Script Executable
```bash
chmod +x setup.sh
```

### Step 3: Run the Script
Run the script with root privileges:
```bash
sudo ./setup.sh
```

---

## Script Workflow

1. **Install Dependencies**:
   - Updates the system and installs Docker, Minikube, Helm, kubectl, and Terraform.

2. **Configure and Start Minikube**:
   - Allocates 2 CPUs and 4GB memory for Minikube.
   - Sets Docker as the driver.
   - Enables the Minikube ingress addon.

3. **Add Helm Repository**:
   - Adds the Oteemo Helm chart repository.

4. **Terraform Deployment**:
   - Initializes and applies the Terraform configuration in the `terraform-project` folder.

5. **Ingress Configuration**:
   - Applies the `ingress.yaml` file to expose SonarQube.

6. **Verify Application**:
   - Retrieves the Minikube IP.
   - Verifies SonarQube is accessible via HTTP using `curl`.

---

## Example Output

```bash
Starting the automation script...
Updating system and installing prerequisites...
Installing Docker...
Installing Minikube...
Installing kubectl...
Installing Helm 3...
Installing Terraform...
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

- **Resource Allocation**: Ensure your system has sufficient resources to allocate 2 CPUs and 4GB of memory to Minikube.
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

