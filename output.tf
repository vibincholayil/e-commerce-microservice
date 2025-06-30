output "server_name" {
  description = "EC2 Instance Name"
  value       = aws_instance.server.tags["Name"]
}

output "server_id" {
  description = "EC2 Instance ID"
  value       = aws_instance.server.id
}

output "instance_public_ip" {
  description = "Public IP of the EC2 instance"
  value       = aws_instance.server.public_ip
}
