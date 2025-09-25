# Using the EC2 module to create a single instance
module "my_ec2_instance" {
  source = "../modules/ec2"
  
  ami_id        = var.ami_id
  instance_type = var.instance_type
  instance_name = "${var.instance_name}-${var.environment}"
  
  additional_tags = {
    Environment = var.environment
    Project     = var.project_name
    CreatedBy   = "Terraform"
  }
}