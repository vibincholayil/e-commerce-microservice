# E-commerce microservice project
This is a end-to-end DevOps Implementation on a Multi-Microservice E-Commerce opentelemetry project

### Introduction 
This project is a demostration of real-time DevOps implementation using a highly popular E-Commerce project open-sourced by OpenTelemetry. This project is widely recognized as one of the best real-world applications for DevOps, and I personally believe it offers the most practical insights.  

### Cloud Infrastructure Setup – configure and deploy a AWS cloud environment.
#### Create an EC2 Instance  
![create_EC2_instance](images/01.png)
I have use ec2 instance with ubuntu image 24.04 t2.medium  (ie: 2vCPU 8 GiB Memory)
```
chmod 400 .pem
ssh -i .pem ubuntu@<ip-address>
```
#### Install Docker
Add Docker's official GPG key:  
```
sudo apt-get update
sudo apt-get install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc
```
Add the repository to Apt sources:  
```
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
```
Install Docker  
```
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
```
Verify Docker Installation  
```
sudo docker run hello-world
```
(optional) create docker group
```
sudo usermod -aG docker ubuntu
```
(optional)check ubuntu user docker group
```
logout
ssh -i .pem ubuntu@<ip-address>
```
```
docker ps
docker images
```
#### Kubectl Installation on Ubuntu EC2
Download kubectl  
```
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
```
Install Kubectl
```
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
```
Verify Kubectl
```
kubectl version --client
```
#### Install Terraform on Ubuntu EC2
Add Hashicorp repos  
```
sudo apt-get update && sudo apt-get install -y gnupg software-properties-common

wget -O- https://apt.releases.hashicorp.com/gpg | \
gpg --dearmor | \
sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg > /dev/null

echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] \
https://apt.releases.hashicorp.com $(lsb_release -cs) main" | \
sudo tee /etc/apt/sources.list.d/hashicorp.list

sudo apt update
```  
Install Terraform  
```
sudo apt-get install terraform
```
Verify Terraform Installation  
```
terraform -help
```
### Try the project in local setup



### Understanding the Project & SDLC – Gain in-depth knowledge of software development lifecycles in microservices-based architectures.
### Containerization with Docker – Learn how to package and manage applications efficiently using Docker.
### Docker Compose Setup – Manage multi-container applications with Docker Compose.
### Kubernetes for Orchestration – Deploy and manage containers at scale using Kubernetes.
### Infrastructure as Code (IaC) with Terraform 
