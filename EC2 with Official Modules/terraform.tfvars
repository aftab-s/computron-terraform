# AWS Region
aws_region = "us-east-1"

# EC2 Instance Configuration
instance_name = "demo-web-server"
instance_type = "t2.micro"

# AMI Configuration
ami_id = "ami-0c55b159cbfafe1d0"  # Amazon Linux 2 AMI (us-east-1)

# Network Configuration
# IMPORTANT: Replace these with your actual VPC and Subnet IDs
vpc_id    = "vpc-12345678"        # Replace with your VPC ID
subnet_id = "subnet-12345678"     # Replace with your Subnet ID

# Key Pair Configuration
key_pair_name = "demo-web-server-key"
# IMPORTANT: Replace this with your actual public key content
# Generate with: ssh-keygen -t rsa -b 2048 -f ~/.ssh/demo-web-server-key
# Then copy content from: ~/.ssh/demo-web-server-key.pub
public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAA... your-actual-public-key-content-here"

# Security Configuration
# For demo purposes - in production, restrict to specific IP ranges
allowed_cidr_blocks = ["0.0.0.0/0"]
