# EC2 with Security Group - Terraform Demo

This Terraform configuration creates a simple EC2 instance with a Security Group that allows HTTP, HTTPS, and SSH access from anywhere.

## What This Creates

- **EC2 Instance**: Amazon Linux 2 t2.micro instance with Apache web server (named: `demo-web-server`)
- **Security Group**: Allows inbound traffic on ports 22 (SSH), 80 (HTTP), and 443 (HTTPS) (named: `demo-web-server-sg`)
- **Key Pair**: AWS key pair for SSH access (named: `demo-web-server-key`)
- **Sample Web Page**: Simple HTML page showing instance information

## File Structure

- **`providers.tf`**: AWS provider and Terraform configuration
- **`key-pair.tf`**: AWS key pair resource for SSH access
- **`instance-with-sg.tf`**: EC2 instance and security group resources
- **`variables.tf`**: Input variable definitions
- **`outputs.tf`**: Output value definitions
- **`terraform.tfvars`**: Variable values configuration

## Prerequisites

1. **AWS CLI**: Install and configure with your AWS credentials
2. **Terraform**: Install Terraform (version 1.0 or later)
3. **SSH Key Pair**: Generate an SSH key pair for access (instructions below)

## Usage

1. **Generate SSH Key Pair**:
   ```bash
   ssh-keygen -t rsa -b 2048 -f ~/.ssh/demo-web-server-key
   ```

2. **Clone and Navigate**:
   ```bash
   cd "EC2 with SG"
   ```

3. **Configure Variables**:
   ```bash
   # Edit terraform.tfvars and:
   # - Set your key_pair_name (if different from default)
   # - Paste the content of ~/.ssh/demo-web-server-key.pub into public_key
   # - Adjust other settings as needed
   ```

4. **Initialize Terraform**:
   ```bash
   terraform init
   ```

5. **Plan the Deployment**:
   ```bash
   terraform plan
   ```

6. **Apply the Configuration**:
   ```bash
   terraform apply
   ```

7. **Access Your Instance**:
   - **Web Server**: Use the `website_url` output
   - **SSH**: Use `ssh -i ~/.ssh/demo-web-server-key ec2-user@<public-ip>`

8. **Clean Up**:
   ```bash
   terraform destroy
   ```

## Resource Naming

All resources follow a consistent naming pattern based on the `instance_name` variable:

- **EC2 Instance**: `demo-web-server`
- **Security Group**: `demo-web-server-sg` 
- **Key Pair**: `demo-web-server-key`

This makes it easy to identify related resources in the AWS console.

## Security Group Rules

- **SSH (Port 22)**: Access from anywhere (0.0.0.0/0)
- **HTTP (Port 80)**: Access from anywhere (0.0.0.0/0)
- **HTTPS (Port 443)**: Access from anywhere (0.0.0.0/0)
- **Outbound**: All traffic allowed

## Important Notes

- This setup allows access from anywhere (0.0.0.0/0) for demonstration purposes
- In production, restrict access to specific IP ranges
- The t2.micro instance type is eligible for AWS Free Tier
- All resources use consistent naming based on the `instance_name` variable
- Make sure to destroy resources when done to avoid charges
