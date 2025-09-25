# 🚀 Computron Training - Terraform Series

Welcome to the **Computron Terraform Training Repository**! This resource takes you from Terraform beginner to advanced practitioner through hands-on examples.

## 📚 **Directory Structure & Learning Path**

```
s:\Computron\Terraform\
├── 📖 README.md                    # This guide
├── 📁 Notes/                       # Reference files
│   └── 📝 notes.txt                # Variable precedence reference
├── 🔧 AWS/                         # Basic AWS resource examples
├── 📁 Local File/                  # Local provider examples  
├── 📁 Local Provider/              # Advanced local provider usage
├── 📁 Variables/                   # Variable demonstrations
├── 🧩 modules/ec2/                 # Reusable EC2 module
├── 📚 EC2-Module-Example/          # Module usage (beginner-friendly)
├── 🧮 Built-In-Functions/          # Complete function reference
└── 🔧 Provisioners-Demo/           # Provisioner examples
```

## 🎯 **Quick Start**

**Prerequisites**: Terraform (>= 0.14), AWS CLI, PowerShell, VS Code (recommended)

**Getting Started**:
1. Clone/Download this repository
2. Choose your learning path based on experience level
3. Follow the progression from basic to advanced topics

## 📖 **Learning Modules**

### **🌱 Level 1: Terraform Basics**

| Directory | What You'll Learn | Time |
|-----------|-------------------|------|
| **[`Variables/`](./Variables/)** | Input variables, variable files, precedence | 25 min |
| **[`AWS/`](./AWS/)** | Basic resource creation, providers, state files | 30 min |
| **[`Local File/`](./Local%20File/)** | Local resources, file management | 20 min |

### **🌿 Level 2: Intermediate Concepts**

| Directory | What You'll Learn | Time |
|-----------|-------------------|------|
| **[`modules/ec2/`](./modules/ec2/)** | Module creation, code organization | 45 min |
| **[`EC2-Module-Example/`](./EC2-Module-Example/)** ⭐ | Module usage (beginner-friendly) | 30 min |
| **[`Built-In-Functions/`](./Built-In-Functions/)** ⭐ | 65+ functions across 9 categories | 60-90 min |

### **🌳 Level 3: Advanced Topics**

| Directory | What You'll Learn | Time |
|-----------|-------------------|------|
| **[`Provisioners-Demo/`](./Provisioners-Demo/)** | Post-deployment actions, best practices | 45 min |

## 🎓 **Recommended Learning Paths**

- **👶 Complete Beginner**: Variables → AWS → EC2-Module-Example → Built-In-Functions
- **🧑 Some Experience**: EC2-Module-Example → modules/ec2 → Built-In-Functions → Provisioners-Demo
- **👨‍💼 Experienced**: Built-In-Functions → modules/ec2 → Provisioners-Demo

## 📝 **Key Concepts Covered**

**🔧 Core**: Resources, Providers, Variables, Outputs, State Management, HCL Syntax  
**🏗️ Advanced**: Modules, Functions, Conditionals, Loops, Provisioners, Templates  
**🎯 Best Practices**: Code Organization, Variable Management, Error Handling, Security

## 📋 **Variable Precedence** (from [`Notes/notes.txt`](./Notes/notes.txt))

```
CLI Flags > Terraform.tfvars > Variables.tf
```

**Full order**: CLI flags → terraform.tfvars → Environment variables → Variable defaults

## 🛠️ **Essential Commands**

```powershell
terraform init      # Initialize directory
terraform plan      # Preview changes
terraform apply     # Apply configuration
terraform destroy   # Remove infrastructure
terraform validate  # Check syntax
terraform fmt       # Format code
terraform console   # Test functions interactively
```

## 🎮 **Interactive Features**

- **Documentation**: README files in key directories (`modules/ec2/`, `EC2-Module-Example/`, `Built-In-Functions/`, `Provisioners-Demo/`)
- **Experimentation**: Modify `terraform.tfvars` files to see different outcomes
- **Safe Learning**: Most examples use local providers (free), AWS examples use t2.micro (free tier)

## 🚨 **Important Notes**

- **Cost**: Always run `terraform destroy` after testing AWS examples
- **Security**: Never commit secrets to version control
- **Best Practice**: Start with beginner-friendly examples, read directory READMEs first

## 🆘 **Need Help?**

- **Docs**: [Terraform](https://www.terraform.io/docs) | [AWS Provider](https://registry.terraform.io/providers/hashicorp/aws)
- **Troubleshooting**: `terraform validate` → `terraform plan` → Check `.terraform/` directory
- **Pro Tip**: Use `terraform console` to test functions interactively

## 🎉 **Ready to Start?**

**🌱 New to Terraform?** → Start with [`Variables/`](./Variables/)  
**🎯 Want hands-on experience?** → Jump to [`EC2-Module-Example/`](./EC2-Module-Example/)  
**🧮 Want to master functions?** → Explore [`Built-In-Functions/`](./Built-In-Functions/)

---

**Welcome to your Terraform learning journey! 🚀**