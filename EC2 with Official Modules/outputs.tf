output "instance_id" {
  description = "ID of the EC2 instance"
  value       = module.ec2_instance.id
}

output "instance_public_ip" {
  description = "Public IP address of the EC2 instance"
  value       = module.ec2_instance.public_ip
}

output "instance_public_dns" {
  description = "Public DNS name of the EC2 instance"
  value       = module.ec2_instance.public_dns
}

output "key_pair_name" {
  description = "Name of the created key pair"
  value       = module.key_pair.key_pair_name
}

output "security_group_id" {
  description = "ID of the security group"
  value       = module.security_group.security_group_id
}

output "security_group_name" {
  description = "Name of the security group"
  value       = module.security_group.security_group_name
}

output "website_url" {
  description = "URL to access the web server"
  value       = "http://${module.ec2_instance.public_ip}"
}

output "ssh_connection_command" {
  description = "Command to SSH into the instance"
  value       = "ssh -i ~/.ssh/${var.key_pair_name} ec2-user@${module.ec2_instance.public_ip}"
}

output "vpc_id" {
  description = "ID of the VPC used"
  value       = var.vpc_id
}

output "subnet_id" {
  description = "ID of the subnet used"
  value       = var.subnet_id
}
