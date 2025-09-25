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

variable "ami_id" {
  description = "AMI ID for the EC2 instance"
  type        = string
  default     = "ami-0c55b159cbfafe1d0"  # Amazon Linux 2 AMI (us-east-1)
}
