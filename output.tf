output "region" {
  description = "The AWS region where the resources are created"
  value       = var.region
} 

output "vpc_cidr" {
  description = "The ID of the VPC"
  value       = var.vpc_cidr
}
