variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "us-east-1"
}

variable "instance_name" {
  description = "Name tag for the EC2 instance"
  type        = string
  default     = "demo-web-server"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}

variable "key_pair_name" {
  description = "Name of the AWS key pair for SSH access"
  type        = string
  default     = "demo-web-server-key"
}

variable "public_key" {
  description = "Public key content for the key pair"
  type        = string
  default     = ""
  
  validation {
    condition     = var.public_key != ""
    error_message = "Public key content must be provided for SSH access."
  }
}

variable "allowed_cidr_blocks" {
  description = "List of CIDR blocks allowed to access the instance"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "ami_id" {
  description = "AMI ID for the EC2 instance"
  type        = string
  default     = "ami-0c55b159cbfafe1d0"  # Amazon Linux 2 AMI (us-east-1)
}

variable "vpc_id" {
  description = "VPC ID where resources will be created"
  type        = string
  default     = ""
  
  validation {
    condition     = var.vpc_id != ""
    error_message = "VPC ID must be provided."
  }
}

variable "subnet_id" {
  description = "Subnet ID where the EC2 instance will be created"
  type        = string
  default     = ""
  
  validation {
    condition     = var.subnet_id != ""
    error_message = "Subnet ID must be provided."
  }
}
