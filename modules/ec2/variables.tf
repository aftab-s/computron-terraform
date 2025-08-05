variable "ami_id" {
  description = "The AMI ID to use for the EC2 instance"
  type        = string
  default     = "ami-08a6efd148b1f7504"
}

variable "instance_type" {
  description = "The type of EC2 instance to launch"
  type        = string
  default     = "t2.micro"
}

variable "instance_name" {
  description = "The name tag for the EC2 instance"
  type        = string
  default     = "ExampleInstance"
}

variable "additional_tags" {
  description = "Additional tags to apply to the EC2 instance"
  type        = map(string)
  default     = {}
}
