terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.region
}

resource "aws_vpc" "vibin_vpc" {
    cidr_block = var.vpc_cidr

    tags = {
     Name = "vibin_vpc"
    }
}

resource "aws_subnet" "myprivatesubnet" {
  vpc_id     = aws_vpc.vibin_vpc.id
  cidr_block = var.private_subnet_cidrs

  tags = {
    Name = "my_private_subnet"
  }
}


resource "aws_subnet" "mypublicsubnet" {
  vpc_id     = aws_vpc.vibin_vpc.id
  cidr_block = var.public_subnet_cidrs

  tags = {
    Name = "my_public_subnet"
  }
}

# create internet gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vibin_vpc.id
}



# NAT gateway resource attached with vpc
resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = aws_eip.igw_eip.id
  subnet_id     = aws_subnet.mypublicsubnet.id
}


# create elastic ip for NAT gateway
resource "aws_eip" "igw_eip" {
  domain = "vpc"
}

# create RT for pvt subnet
resource "aws_route_table" "pvt_rt" {
  vpc_id = aws_vpc.vibin_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
  nat_gateway_id = aws_nat_gateway.nat_gateway.id
 }
}

# create RT for pub subnet  
resource "aws_route_table" "pub_rt" {
  vpc_id = aws_vpc.vibin_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
 }
}


# associate RT with pvt subnet
resource "aws_route_table_association" "pvt_rt_assoc" {
  subnet_id      = aws_subnet.myprivatesubnet.id
  route_table_id = aws_route_table.pvt_rt.id
}


# associate RT with pub subnet
resource "aws_route_table_association" "pub_rt_assoc" {
  subnet_id      = aws_subnet.mypublicsubnet.id
  route_table_id = aws_route_table.pub_rt.id
}