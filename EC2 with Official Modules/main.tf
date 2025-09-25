# Create Key Pair using official module
module "key_pair" {
  source = "terraform-aws-modules/key-pair/aws"
  version = "~> 2.0"

  key_name           = var.key_pair_name
  create_private_key = false
  public_key         = var.public_key

  tags = {
    Name        = "${var.instance_name}-key"
    Environment = "demo"
  }
}

# Create Security Group using official module
module "security_group" {
  source = "terraform-aws-modules/security-group/aws"
  version = "~> 5.0"

  name        = "${var.instance_name}-sg"
  description = "Security group for web server - allows HTTP, HTTPS, and SSH"
  vpc_id      = var.vpc_id

  # Ingress rules
  ingress_with_cidr_blocks = [
    {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      description = "SSH"
      cidr_blocks = join(",", var.allowed_cidr_blocks)
    },
    {
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      description = "HTTP"
      cidr_blocks = join(",", var.allowed_cidr_blocks)
    },
    {
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      description = "HTTPS"
      cidr_blocks = join(",", var.allowed_cidr_blocks)
    }
  ]

  # Egress rules
  egress_with_cidr_blocks = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      description = "All outbound traffic"
      cidr_blocks = "0.0.0.0/0"
    }
  ]

  tags = {
    Name        = "${var.instance_name}-sg"
    Environment = "demo"
  }
}

# Create EC2 Instance using official module
module "ec2_instance" {
  source = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 5.0"

  name                   = var.instance_name
  ami                    = var.ami_id
  instance_type          = var.instance_type
  key_name               = module.key_pair.key_pair_name
  subnet_id              = var.subnet_id
  vpc_security_group_ids = [module.security_group.security_group_id]

  associate_public_ip_address = true
  
  # User data script to install and start Apache
  user_data = base64encode(<<-EOF
              #!/bin/bash
              yum update -y
              yum install -y httpd
              systemctl start httpd
              systemctl enable httpd
              echo "<h1>Hello from EC2 Instance (Official Modules)!</h1>" > /var/www/html/index.html
              EOF
  )

  tags = {
    Name        = var.instance_name
    Environment = "demo"
    Terraform   = "true"
  }
}
