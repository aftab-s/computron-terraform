# 🎓 Terraform Functions - Teaching Guide

## For Instructors Teaching Terraform Functions

### 📋 **Lesson Plan Structure**

#### **Session 1: Basic Functions (30 mins)**
- **String Functions**: `upper()`, `lower()`, `length()`
- **List Functions**: `length()`, `join()`, `contains()`
- **Hands-on**: Modify `terraform.tfvars` and see outputs change

#### **Session 2: Data Manipulation (30 mins)**
- **Map Functions**: `lookup()`, `keys()`, `values()`
- **Numeric Functions**: `max()`, `min()`, `sum()`
- **Hands-on**: Create custom variable sets

#### **Session 3: Advanced Logic (45 mins)**
- **Conditional Functions**: `?:`, `coalesce()`, `try()`
- **Collection Functions**: `for` expressions, `merge()`
- **Hands-on**: Build conditional resource naming

#### **Session 4: Real-World Applications (45 mins)**
- **Network Functions**: `cidrsubnet()`, `cidrhost()`
- **Template Functions**: `templatefile()`
- **Hands-on**: Create dynamic infrastructure

### 🎯 **Teaching Approach**

#### **1. Start Simple**
```hcl
# Begin with obvious functions
output "example" {
  value = upper("hello world")  # Result: "HELLO WORLD"
}
```

#### **2. Build Complexity Gradually**
```hcl
# Progress to combinations
output "complex_example" {
  value = join("-", [upper(var.project), lower(var.environment)])
}
```

#### **3. Show Real-World Usage**
```hcl
# Demonstrate practical applications
resource "aws_instance" "web" {
  instance_type = var.environment == "prod" ? "t3.large" : "t2.micro"
  
  tags = merge(var.common_tags, {
    Name = "${var.project}-${var.environment}-${formatdate("YYYYMMDD", timestamp())}"
  })
}
```

### 💡 **Common Student Questions & Answers**

**Q: "When would I use `lookup()` vs direct map access?"**
```hcl
# Direct access - fails if key doesn't exist
instance_type = var.instance_types[var.environment]  # ERROR if key missing

# Lookup - provides fallback
instance_type = lookup(var.instance_types, var.environment, "t2.micro")  # Safe
```

**Q: "What's the difference between `merge()` and map concatenation?"**
```hcl
# merge() combines maps
tags = merge(var.common_tags, var.specific_tags)

# This doesn't work - you can't "add" maps
# tags = var.common_tags + var.specific_tags  # ERROR
```

**Q: "Why use `try()` instead of conditionals?"**
```hcl
# try() is cleaner for error handling
value = try(data.aws_instance.example.private_ip, "not-found")

# vs complex conditional
value = length(data.aws_instance.example) > 0 ? data.aws_instance.example.private_ip : "not-found"
```

### 🔧 **Interactive Exercises**

#### **Exercise 1: Name Generator**
Students create a function that generates resource names:
```hcl
locals {
  resource_name = "${lower(var.project)}-${var.environment}-${formatdate("YYYYMMDD", timestamp())}"
}
```

#### **Exercise 2: Tag Merger**
Students merge different tag sets:
```hcl
locals {
  final_tags = merge(
    var.common_tags,
    var.environment_tags,
    { CreatedAt = timestamp() }
  )
}
```

#### **Exercise 3: Subnet Calculator**
Students generate subnet CIDRs:
```hcl
locals {
  subnet_cidrs = [
    for i in range(var.subnet_count) : 
    cidrsubnet(var.vpc_cidr, 8, i)
  ]
}
```

### 📊 **Assessment Ideas**

#### **Quiz Questions**
1. What does `length(["a", "b", "c"])` return?
2. How do you safely get a map value that might not exist?
3. What's the difference between `upper()` and `title()`?

#### **Practical Tasks**
1. Create a dynamic naming convention using functions
2. Build a conditional resource configuration
3. Generate a list of subnet CIDRs from a VPC CIDR

### 🎮 **Live Demo Script**

```powershell
# 1. Show basic output
terraform output string_functions

# 2. Modify variables
# Edit terraform.tfvars - change project_name to "DEMO"
terraform apply

# 3. Show the change
terraform output string_functions
# Point out how upper() affected the output

# 4. Show template file
Get-Content function-demo-output.txt
# Explain templatefile() function
```

### 📚 **Additional Resources for Students**

- **Terraform Function Documentation**: https://www.terraform.io/language/functions
- **Interactive Function Testing**: Use `terraform console`
- **Practice Exercises**: This directory's examples

### 🎯 **Key Takeaways to Emphasize**

1. **Functions make Terraform dynamic** - not just static configuration
2. **Error handling is important** - use `try()`, `coalesce()`, `lookup()`
3. **Functions compose** - you can chain them together
4. **Test in `terraform console`** - great for learning and debugging

### 📝 **Homework Assignments**

#### **Beginner Assignment**
Create a Terraform configuration that uses at least 5 different string and list functions.

#### **Intermediate Assignment**
Build a module that uses conditional functions to create different resources based on environment.

#### **Advanced Assignment**
Create a network module that automatically calculates subnet CIDRs using network functions.

---
**This comprehensive example gives students hands-on experience with 65+ Terraform functions! 🚀**
