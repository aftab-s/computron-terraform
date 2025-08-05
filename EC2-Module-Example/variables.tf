variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "us-east-1"
}

variable "aws_profile" {
  description = "AWS profile to use for authentication"
  type        = string
  default     = "008971661427_AdministratorAccess"
}

variable "environment" {
  description = "Environment name (e.g., dev, staging, prod)"
  type        = string
  default     = "development"
}

variable "project_name" {
  description = "Name of the project"
  type        = string
  default     = "my-first-module"
}

# EC2 Instance Variables
variable "ami_id" {
  description = "AMI ID for the EC2 instance"
  type        = string
  default     = "ami-08a6efd148b1f7504"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}

variable "instance_name" {
  description = "Name for the EC2 instance"
  type        = string
  default     = "MyServer"
}
