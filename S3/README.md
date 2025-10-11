# S3 Bucket Terraform Configuration

This directory demonstrates how to provision and manage AWS S3 buckets using Terraform.

## 📁 Files Overview

- `main.tf` - S3 bucket resources and configuration
- `variables.tf` - Input variables for customization
- `outputs.tf` - Output values after provisioning
- `provider.tf` - AWS provider and Terraform version requirements
- `terraform.tfvars` - Sample variable values

## 🎯 Learning Objectives

- Create S3 buckets with Terraform
- Configure bucket versioning and encryption
- Implement public access blocking
- Use Terraform outputs effectively

## 🛠️ Usage Instructions

1. **Initialize Terraform**
   ```powershell
   terraform init
   ```

2. **Review the execution plan**
   ```powershell
   terraform plan
   ```

3. **Apply the configuration**
   ```powershell
   terraform apply
   ```

4. **Verify bucket creation**
   ```powershell
   terraform output
   ```

5. **Clean up resources**
   ```powershell
   terraform destroy
   ```

## 📋 Configuration Options

| Variable | Description | Default | Type |
|----------|-------------|---------|------|
| `bucket_name` | S3 bucket name | `bagel-demo` | string |
| `aws_region` | AWS region | `us-east-1` | string |
| `environment` | Environment name | `development` | string |
| `project_name` | Project name | `bagel-s3-demo` | string |
| `enable_versioning` | Enable bucket versioning | `false` | bool |
| `block_public_access` | Block public access | `true` | bool |

## 🔐 Security Features

- **Server-side encryption** with AWS managed keys (AES256)
- **Public access blocking** to prevent accidental exposure
- **Versioning support** for data protection

## 📤 Outputs

The configuration provides useful outputs:
- Bucket ID and ARN
- Domain names (standard and regional)
- Configuration summary
- Versioning status

## 💡 Tips

- Update `terraform.tfvars` with your specific values
- Use unique bucket names (globally unique requirement)
- Review AWS S3 pricing before deployment

## 🔧 Customization

To customize the S3 bucket:
1. Edit `terraform.tfvars` with your values so that you have the name you prefer
2. Add additional bucket features as required

This example demonstrates S3 bucket provisioning with Terraform.
