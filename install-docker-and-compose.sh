#!/bin/bash

# Step 1: Update the package repository
sudo apt-get update -y

echo "Installing dependencies..."
sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Update package database with Docker packages
sudo apt-get update -y

# Install Docker
sudo apt-get install -y docker-ce docker-ce-cli containerd.io

# Start and enable Docker service
sudo systemctl start docker
sudo systemctl enable docker

# user to the Docker group (no need for sudo to run docker commands)
echo "Adding the current user to the Docker group..."
sudo usermod -aG docker $USER

echo "Verifying Docker installation..."
docker --version

echo "Docker installation completed successfully!"

# run test docker "hello-world" image 
docker run hello-world
