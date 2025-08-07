# EC2 with Official Modules - Terraform Demo

This Terraform configuration creates the same EC2 setup as the basic version, but uses **official Terraform AWS modules** for better practices, more features, and standardized configurations.

## What This Creates

- **EC2 Instance**: Amazon Linux 2 t2.micro instance with Apache web server (using `terraform-aws-modules/ec2-instance/aws`)
- **Security Group**: Allows inbound traffic on ports 22 (SSH), 80 (HTTP), and 443 (HTTPS) (using `terraform-aws-modules/security-group/aws`)
- **Key Pair**: AWS key pair for SSH access (using `terraform-aws-modules/key-pair/aws`)
- **Sample Web Page**: Enhanced HTML page showing instance information and module usage

## Official Modules Used

- **[terraform-aws-modules/ec2-instance/aws](https://registry.terraform.io/modules/terraform-aws-modules/ec2-instance/aws)**: EC2 instance management
- **[terraform-aws-modules/security-group/aws](https://registry.terraform.io/modules/terraform-aws-modules/security-group/aws)**: Security group management  
- **[terraform-aws-modules/key-pair/aws](https://registry.terraform.io/modules/terraform-aws-modules/key-pair/aws)**: Key pair management

## File Structure

- **`providers.tf`**: AWS provider and Terraform configuration
- **`main.tf`**: Module configurations and data sources
- **`variables.tf`**: Input variable definitions
- **`outputs.tf`**: Output value definitions (enhanced with module outputs)
- **`terraform.tfvars`**: Variable values configuration

## Benefits of Using Official Modules

✅ **Best Practices**: Modules follow AWS and Terraform best practices  
✅ **Feature Rich**: More configuration options and sensible defaults  
✅ **Well Tested**: Modules are thoroughly tested by the community  
✅ **Maintained**: Regular updates and security patches  
✅ **Documentation**: Comprehensive documentation and examples  
✅ **Consistent**: Standardized approach across projects  

## Comparison with Basic Setup

| Feature | Basic Setup | Official Modules |
|---------|-------------|------------------|
| **Lines of Code** | ~70 lines | ~40 lines (main logic) |
| **Configuration** | Manual resource definition | Module-based configuration |
| **Features** | Basic functionality | Extended options available |
| **Maintenance** | Manual updates needed | Module updates handle changes |
| **Best Practices** | DIY implementation | Built-in best practices |

## Prerequisites

1. **AWS CLI**: Install and configure with your AWS credentials
2. **Terraform**: Install Terraform (version 1.0 or later)
3. **SSH Key Pair**: Generate an SSH key pair for access (instructions below)

## Usage

1. **Generate SSH Key Pair**:
   ```bash
   ssh-keygen -t rsa -b 2048 -f ~/.ssh/demo-web-server-key
   ```

2. **Navigate to Directory**:
   ```bash
   cd "EC2 with Official Modules"
   ```

3. **Configure Variables**:
   ```bash
   # Edit terraform.tfvars and:
   # - Set your VPC ID and Subnet ID (get from AWS console)
   # - Set your AMI ID for your region (if different)
   # - Set your key_pair_name (if different from default)
   # - Paste the content of ~/.ssh/demo-web-server-key.pub into public_key
   # - Adjust allowed_cidr_blocks for security (optional)
   ```

4. **Get VPC and Subnet Information**:
   ```bash
   # To find your default VPC ID:
   aws ec2 describe-vpcs --filters "Name=is-default,Values=true" --query "Vpcs[0].VpcId" --output text
   
   # To find subnet ID in your default VPC:
   aws ec2 describe-subnets --filters "Name=vpc-id,Values=<your-vpc-id>" --query "Subnets[0].SubnetId" --output text
   ```

5. **Initialize Terraform** (downloads modules):
   ```bash
   terraform init
   ```

6. **Plan the Deployment**:
   ```bash
   terraform plan
   ```

7. **Apply the Configuration**:
   ```bash
   terraform apply
   ```

8. **Access Your Instance**:
   - **Web Server**: Use the `website_url` output
   - **SSH**: Use `ssh -i ~/.ssh/demo-web-server-key ec2-user@<public-ip>`

9. **Clean Up**:
   ```bash
   terraform destroy
   ```

## Configuration Requirements

### Required Variables:
- **`vpc_id`**: Your VPC ID (find using AWS CLI or console)
- **`subnet_id`**: Your subnet ID (must be in the specified VPC)
- **`ami_id`**: AMI ID for your region
- **`public_key`**: Your SSH public key content

### Finding AWS Resources:
```bash
# Get default VPC ID
aws ec2 describe-vpcs --filters "Name=is-default,Values=true" --query "Vpcs[0].VpcId" --output text

# Get subnet IDs in VPC
aws ec2 describe-subnets --filters "Name=vpc-id,Values=YOUR_VPC_ID" --query "Subnets[*].SubnetId" --output table

# Get latest Amazon Linux 2 AMI for your region
aws ec2 describe-images --owners amazon --filters "Name=name,Values=amzn2-ami-hvm-*-x86_64-gp2" --query "Images | sort_by(@, &CreationDate) | [-1].ImageId" --output text
```

## Enhanced Features

### Security Group Module Features:
- More flexible ingress/egress rule definitions
- Better rule descriptions and organization
- Built-in validation and error handling

### EC2 Instance Module Features:
- Automatic public IP association
- Enhanced tagging capabilities
- Better subnet and VPC handling
- Built-in user data encoding

### Key Pair Module Features:
- Option to create or import keys
- Better error handling
- Consistent tagging

## Security Configuration

The `allowed_cidr_blocks` variable allows you to easily restrict access:

```hcl
# For demo (current setting)
allowed_cidr_blocks = ["0.0.0.0/0"]

# For production (example)
allowed_cidr_blocks = ["10.0.0.0/8", "192.168.1.0/24"]
```

## Resource Naming

All resources follow the same consistent naming pattern:

- **EC2 Instance**: `demo-web-server`
- **Security Group**: `demo-web-server-sg`
- **Key Pair**: `demo-web-server-key`

## Important Notes

- Modules are downloaded during `terraform init`
- This setup uses the default VPC and subnets
- All resources include proper tagging for better organization
- The web page indicates it was deployed using official modules
- Module versions are pinned for consistency (`~> 5.0`, `~> 2.0`)
- Make sure to destroy resources when done to avoid charges

## Next Steps

Consider exploring these additional official modules:
- `terraform-aws-modules/vpc/aws` - For custom VPC setup
- `terraform-aws-modules/autoscaling/aws` - For auto-scaling groups
- `terraform-aws-modules/elb/aws` - For load balancers
