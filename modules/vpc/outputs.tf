output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.vibin_vpc.id
}

output "private_subnet_id" {
  description = "The ID of the private subnet"
  value       = aws_subnet.myprivatesubnet.id
}

output "public_subnet_id" {
  description = "The ID of the public subnet"
  value       = aws_subnet.mypublicsubnet.id
}

output "internet_gateway_id" {
  description = "The ID of the Internet Gateway"
  value       = aws_internet_gateway.igw.id
}

output "nat_gateway_id" {
  description = "The ID of the NAT Gateway"
  value       = aws_nat_gateway.nat_gateway.id
}

output "eip_allocation_id" {
  description = "The Elastic IP allocation ID for NAT Gateway"
  value       = aws_eip.igw_eip.id
}
