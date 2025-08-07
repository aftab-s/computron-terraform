output "instance_id" {
  description = "ID of the EC2 instance"
  value       = aws_instance.web_server.id
}

output "key_pair_name" {
  description = "Name of the created key pair"
  value       = aws_key_pair.web_server_key.key_name
}

output "instance_public_ip" {
  description = "Public IP address of the EC2 instance"
  value       = aws_instance.web_server.public_ip
}

output "instance_public_dns" {
  description = "Public DNS name of the EC2 instance"
  value       = aws_instance.web_server.public_dns
}

output "security_group_id" {
  description = "ID of the security group"
  value       = aws_security_group.web_sg.id
}

output "website_url" {
  description = "URL to access the web server"
  value       = "http://${aws_instance.web_server.public_ip}"
}

output "ssh_connection_command" {
  description = "Command to SSH into the instance"
  value       = "ssh -i ~/.ssh/${var.key_pair_name} ec2-user@${aws_instance.web_server.public_ip}"
}
