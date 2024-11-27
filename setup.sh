#!/bin/bash

set -e  # Exit on error

# Function to install dependencies
install_dependencies() {
  echo "Updating system and installing prerequisites..."
  sudo apt-get update -y
  sudo apt-get upgrade -y
  sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common

  echo "Installing KVM and dependencies..."
  sudo apt-get install -y qemu-kvm libvirt-daemon-system libvirt-clients bridge-utils
  sudo apt-get install -y virt-manager

  echo "Adding user to the 'libvirt' group..."
  sudo usermod -aG libvirt $USER

  echo "Installing Minikube..."
  curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
  sudo install minikube-linux-amd64 /usr/local/bin/minikube
  rm minikube-linux-amd64

  echo "Installing kubectl..."
  curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
  sudo install kubectl /usr/local/bin/kubectl
  rm kubectl

  echo "Installing Helm 3..."
  curl https://baltocdn.com/helm/signing.asc | gpg --dearmor | sudo tee /usr/share/keyrings/helm.gpg > /dev/null
  sudo apt-get install apt-transport-https --yes
  echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/helm.gpg] https://baltocdn.com/helm/stable/debian/ all main" | sudo tee /etc/apt/sources.list.d/helm-stable-debian.list
  sudo apt-get update
  sudo apt-get install -y helm

  echo "Installing Terraform..."
  curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
  sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
  sudo apt-get update -y
  sudo apt-get install -y terraform
}

# Function to configure and start Minikube with KVM2 driver
configure_minikube() {
  echo "Configuring Minikube with KVM2 driver..."
  minikube config set cpus 2
  minikube config set memory 4096
  minikube config set driver kvm2

  echo "Starting Minikube..."
  minikube start
  minikube addons enable ingress
}

# Function to add Helm repository
add_helm_repo() {
  echo "Adding Helm repository..."
  helm repo add oteemocharts https://oteemo.github.io/charts
  helm repo update
}

# Function to deploy using Terraform
deploy_terraform() {
  echo "Navigating to Terraform folder..."
  cd terraform-project

  echo "Initializing Terraform..."
  terraform init

  echo "Applying Terraform configuration..."
  terraform apply -auto-approve
}

# Function to apply Kubernetes ingress and verify deployment
verify_deployment() {
  echo "Applying ingress.yaml..."
  kubectl apply -f ingress.yaml

  echo "Getting Minikube IP..."
  MINIKUBE_IP=$(minikube ip)
  echo "Minikube IP: $MINIKUBE_IP"

  echo "Waiting for SonarQube application to be ready..."
  sleep 30  # Adjust the sleep time based on your cluster's performance

  echo "Verifying SonarQube application..."
  curl -I "http://$MINIKUBE_IP"
}

# Main script execution
echo "Starting the automation script..."
install_dependencies
configure_minikube
add_helm_repo
deploy_terraform
verify_deployment

echo "Automation script completed successfully!"
