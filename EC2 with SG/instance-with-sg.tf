# Create Security Group
resource "aws_security_group" "web_sg" {
  name        = "${var.instance_name}-sg"
  description = "Security group for web server - allows HTTP, HTTPS, and SSH"

  # SSH access from anywhere
  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # HTTP access from anywhere
  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # HTTPS access from anywhere
  ingress {
    description = "HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # All outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.instance_name}-sg"
  }

  depends_on = [ aws_key_pair.web_server_key ] # Explicit Dependency
}

# Create EC2 Instance
resource "aws_instance" "web_server" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  key_name              = aws_key_pair.web_server_key.key_name
  vpc_security_group_ids = [aws_security_group.web_sg.id] 

  # depends_on = [ aws_security_group.web_sg ] Explicit Dependency

  # User data script to install and start Apache
  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              yum install -y httpd
              systemctl start httpd
              systemctl enable httpd
              echo "<h1>Hello from EC2 Instance!</h1>" > /var/www/html/index.html
              EOF

  tags = {
    Name = var.instance_name
  }
}
