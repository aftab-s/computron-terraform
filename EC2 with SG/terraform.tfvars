# AWS Region
aws_region = "us-east-1"

# EC2 Instance Configuration
instance_name = "demo-web-server"
instance_type = "t2.micro"

# AMI ID (Amazon Linux 2 for us-east-1)
ami_id = "ami-0c55b159cbfafe1d0"

# Key Pair Configuration
key_pair_name = "demo-web-server-key"
# IMPORTANT: Replace this with your actual public key content
# Generate with: ssh-keygen -t rsa -b 2048 -f ~/.ssh/demo-web-server-key
# Then copy content from: ~/.ssh/demo-web-server-key.pub
public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAA... your-actual-public-key-content-here"
