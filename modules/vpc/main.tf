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
  for_each   = toset(var.private_subnet_cidrs)
  vpc_id     = aws_vpc.vibin_vpc.id
  cidr_block = each.key

  tags = {
    Name = "my_private_subnet-${each.key}"
  }
}

resource "aws_subnet" "mypublicsubnet" {
  for_each   = toset(var.public_subnet_cidrs)
  vpc_id     = aws_vpc.vibin_vpc.id
  cidr_block = each.key

  tags = {
    Name = "my_public_subnet-${each.key}"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vibin_vpc.id
}

resource "aws_eip" "igw_eip" {
  domain = "vpc"
}

resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = aws_eip.igw_eip.id
  subnet_id     = aws_subnet.mypublicsubnet[var.public_subnet_cidrs[0]].id
}

resource "aws_route_table" "pvt_rt" {
  vpc_id = aws_vpc.vibin_vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gateway.id
  }
}

resource "aws_route_table" "pub_rt" {
  vpc_id = aws_vpc.vibin_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}

resource "aws_route_table_association" "pvt_rt_assoc" {
  subnet_id      = aws_subnet.myprivatesubnet[var.private_subnet_cidrs[0]].id
  route_table_id = aws_route_table.pvt_rt.id
}

resource "aws_route_table_association" "pub_rt_assoc" {
  subnet_id      = aws_subnet.mypublicsubnet[var.public_subnet_cidrs[0]].id
  route_table_id = aws_route_table.pub_rt.id
}
