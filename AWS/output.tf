output "aws_instance_id" {
  value = aws_instance.example.id  
}

output "aws_instance_public_ip" {
  value = aws_instance.example.public_ip
}

output "aws_instance_private_ip" {
  value = aws_instance.example.private_ip
}