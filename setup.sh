#!/bin/bash

# Script to configure Minikube and deploy applications using Terraform

set -e  # Exit on error

# Function to configure and start Minikube with Docker driver
configure_minikube() {
  echo "Configuring Minikube with Docker driver..."
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
configure_minikube
add_helm_repo
deploy_terraform
verify_deployment

echo "Automation script completed successfully!"
