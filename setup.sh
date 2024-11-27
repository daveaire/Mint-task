#!/bin/bash

# Script to automate the installation of dependencies and deployment using Terraform and Minikube

set -e  # Exit on error

# Function to install dependencies
install_dependencies() {
  echo "Updating system and installing prerequisites..."
  sudo apt-get update -y
  sudo apt-get upgrade -y
  sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common

  echo "Installing Docker..."
  # Add Docker's official GPG key
  sudo install -m 0755 -d /etc/apt/keyrings
  sudo curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
  sudo chmod a+r /etc/apt/keyrings/docker.asc

  # Add Docker repository
  echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian \
    $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
    sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

  # Update package index and install Docker
  sudo apt-get update -y
  sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

  # Start Docker service
  sudo systemctl start docker
  sudo systemctl enable docker

  echo "Docker installed successfully."
  
  echo "Installing Minikube..."
  curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
  sudo install minikube-linux-amd64 /usr/local/bin/minikube
  rm minikube-linux-amd64

  echo "Installing kubectl..."
  curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
  sudo install kubectl /usr/local/bin/kubectl
  rm kubectl

  echo "Installing Helm 3..."
  curl https://baltocdn.com/helm/signing.asc | sudo apt-key add -
  sudo apt-get install -y helm

  echo "Installing Terraform..."
  curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
  sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
  sudo apt-get update -y
  sudo apt-get install -y terraform
}

# Function to configure and start Minikube
configure_minikube() {
  echo "Configuring Minikube..."
  minikube config set cpus 2
  minikube config set memory 4096
  minikube config set driver docker

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
