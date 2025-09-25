# Outputs for the EC2 instance
output "instance_id" {
  description = "ID of the EC2 instance"
  value       = module.my_ec2_instance.instance_id
}

output "public_ip" {
  description = "Public IP address of the EC2 instance"
  value       = module.my_ec2_instance.public_ip
}

output "private_ip" {
  description = "Private IP address of the EC2 instance"
  value       = module.my_ec2_instance.private_ip
}

output "instance_name" {
  description = "Name of the EC2 instance"
  value       = "${var.instance_name}-${var.environment}"
}

# Summary output
output "deployment_info" {
  description = "Summary of what was created"
  value = {
    instance_name = "${var.instance_name}-${var.environment}"
    environment   = var.environment
    project       = var.project_name
    region        = var.aws_region
    instance_type = var.instance_type
  }
}
