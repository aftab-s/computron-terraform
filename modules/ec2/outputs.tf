output "instance_id" {
  description = "The ID of the EC2 instance"
  value       = aws_instance.ec2.id
}

output "public_ip" {
  description = "The public IP address of the EC2 instance"
  value       = aws_instance.ec2.public_ip
}

output "private_ip" {
  description = "The private IP address of the EC2 instance"
  value       = aws_instance.ec2.private_ip
}

output "instance_arn" {
  description = "The ARN of the EC2 instance"
  value       = aws_instance.ec2.arn
}

output "public_dns" {
  description = "The public DNS name of the EC2 instance"
  value       = aws_instance.ec2.public_dns
}
