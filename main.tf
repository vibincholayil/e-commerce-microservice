provider "aws" {
  region = "eu-central-1"
}

locals {
  subnet_ids = [
  "subnet-0edefe61191da0dd1",
  "subnet-01b6e9322ea917ebc", 
  "subnet-05b7504fbe78a9951"
  ]
}

resource "aws_instance" "server" {
  ami           = "ami-02003f9f0fde924ea"
  instance_type = "t2.large"
  key_name      = "aws"
  subnet_id     = local.subnet_ids[0]
  vpc_security_group_ids = ["sg-0405cdde1be0d7ba3"]

  root_block_device {
    volume_size = 30
    volume_type = "gp3"
    delete_on_termination = true
  }

  user_data = <<-EOF
    #!/bin/bash
    set -e

    # Update and install required packages
    apt-get update -y
    apt-get install -y ca-certificates curl gnupg lsb-release

    # Add Docker’s official GPG key
    mkdir -p /etc/apt/keyrings
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg

    # Set up the Docker repo
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null

    # Install Docker Engine
    apt-get update -y
    apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

    # Start Docker and enable on boot
    systemctl start docker
    systemctl enable docker

    # Add ubuntu user to docker group (optional)
    usermod -aG docker ubuntu
  EOF



  tags = {
    Name = "aws-server-vibin"
  }
}

/*
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "s3" {
    bucket         = "demo-terraform-eks-state-s3-bucket"
    key            = "terraform.tfstate"
    region         = "eu-central-1"
    dynamodb_table = "terraform-eks-state-locks"
    encrypt        = true
  }
}

provider "aws" {
  region = var.region
}

module "vpc" {
  source = "./modules/vpc"

  vpc_cidr             = var.vpc_cidr
  availability_zones   = var.availability_zones
  private_subnet_cidrs = var.private_subnet_cidrs
  public_subnet_cidrs  = var.public_subnet_cidrs
  cluster_name         = var.cluster_name
}

module "eks" {
  source = "./modules/eks"

  cluster_name    = var.cluster_name
  cluster_version = var.cluster_version
  vpc_id          = module.vpc.vpc_id
  subnet_ids      = module.vpc.private_subnet_ids
  node_groups     = var.node_groups
}
*/
