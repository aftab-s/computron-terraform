# EC2 Module

This module creates an AWS EC2 instance with configurable parameters.

## Usage

```hcl
module "ec2_instance" {
  source = "./modules/ec2"
  
  ami_id        = "ami-08a6efd148b1f7504"
  instance_type = "t2.micro"
  instance_name = "MyInstance"
  
  additional_tags = {
    Environment = "production"
    Project     = "my-project"
  }
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| ami_id | The AMI ID to use for the EC2 instance | `string` | `"ami-08a6efd148b1f7504"` | no |
| instance_type | The type of EC2 instance to launch | `string` | `"t2.micro"` | no |
| instance_name | The name tag for the EC2 instance | `string` | `"ExampleInstance"` | no |
| additional_tags | Additional tags to apply to the EC2 instance | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| instance_id | The ID of the EC2 instance |
| public_ip | The public IP address of the EC2 instance |
| private_ip | The private IP address of the EC2 instance |
| instance_arn | The ARN of the EC2 instance |
| public_dns | The public DNS name of the EC2 instance |

## Requirements

- AWS Provider
- Terraform >= 0.12
