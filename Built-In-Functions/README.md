# 🧮 Terraform Built-In Functions - Complete Guide

This directory demonstrates **ALL** the major built-in functions in Terraform. Perfect for learning and reference!

## 🎯 **What You'll Learn**

This example covers **9 categories** of functions with **65+ function examples**:

### 1. **String Functions** 🔤
- `upper()`, `lower()`, `title()` - Change case
- `length()` - Get string length
- `substr()` - Extract part of string
- `replace()` - Replace text
- `join()`, `split()` - Combine/separate strings
- `trimspace()` - Remove whitespace

### 2. **List Functions** 📋
- `length()` - Count items
- `sort()`, `reverse()` - Reorder lists
- `contains()` - Check if item exists
- `index()` - Find position
- `slice()` - Get part of list
- `concat()` - Combine lists

### 3. **Map Functions** 🗺️
- `keys()`, `values()` - Extract keys/values
- `lookup()` - Get value safely
- `merge()` - Combine maps
- `can()` - Test if key exists

### 4. **Numeric Functions** 🔢
- `max()`, `min()` - Find extremes
- `sum()` - Add numbers
- `abs()` - Absolute value
- `ceil()`, `floor()` - Round numbers
- `range()` - Generate sequences

### 5. **Date/Time Functions** ⏰
- `timestamp()` - Current time
- `formatdate()` - Format dates
- Time zone handling

### 6. **Conditional Functions** ❓
- `condition ? true_val : false_val` - Ternary operator
- `coalesce()` - First non-null value
- `try()` - Error handling

### 7. **Collection Functions** 📦
- `for` expressions - Transform data
- `flatten()` - Flatten nested lists
- `distinct()` - Remove duplicates
- `compact()` - Remove empty values
- `setintersection()`, `setunion()` - Set operations

### 8. **Encoding Functions** 🔐
- `base64encode()`, `base64decode()` - Base64 encoding
- `jsonencode()`, `jsondecode()` - JSON handling
- `urlencode()` - URL encoding

### 9. **Network Functions** 🌐
- `cidrsubnet()` - Calculate subnets
- `cidrhost()` - Calculate host IPs
- `cidrnetmask()` - Get network mask

## 🚀 **How to Use This Example**

### Step 1: Run the Example
```powershell
cd "s:\Computron\Terraform\Built-In-Functions"
terraform init
terraform apply
```

### Step 2: See All Outputs
```powershell
terraform output
```

### Step 3: Check Generated File
The example creates `function-demo-output.txt` showing template functions in action!

### Step 4: Experiment
Modify `terraform.tfvars` and run `terraform apply` again to see how functions work with different inputs.

## 📚 **Learning Path**

### **Beginner** 🌱
Start with these essential functions:
- `length()` - Count things
- `join()` - Combine strings
- `lookup()` - Get map values safely
- `upper()`, `lower()` - Change case

### **Intermediate** 🌿
Learn these useful functions:
- `merge()` - Combine maps
- `contains()` - Check existence
- `formatdate()` - Format dates
- `coalesce()` - Handle nulls

### **Advanced** 🌳
Master these powerful functions:
- `for` expressions - Transform data
- `try()` - Error handling
- `flatten()` - Handle nested data
- `cidrsubnet()` - Network calculations

## 💡 **Real-World Examples**

### **Dynamic Naming**
```hcl
resource_name = "${var.project}-${var.environment}-${formatdate("YYYYMMDD", timestamp())}"
```

### **Conditional Instance Types**
```hcl
instance_type = var.environment == "production" ? "t3.large" : "t2.micro"
```

### **Generate Multiple Subnets**
```hcl
subnet_cidrs = [for i in range(3) : cidrsubnet("10.0.0.0/16", 8, i)]
```

### **Safe Map Lookups**
```hcl
instance_type = lookup(var.instance_types, var.environment, "t2.micro")
```

## 🎮 **Interactive Learning**

Try changing these in `terraform.tfvars`:

```hcl
# Change environment to see conditional logic
environment = "production"  # or "staging"

# Try different lists
sample_list = ["red", "green", "blue", "yellow"]

# Experiment with numbers
sample_numbers = [5, 15, 25, 35, 45]
```

Then run `terraform apply` to see how outputs change!

## 📖 **Function Categories Quick Reference**

| Category | Key Functions | Use Cases |
|----------|--------------|-----------|
| **String** | `upper`, `join`, `replace` | Naming, formatting |
| **List** | `length`, `contains`, `sort` | Data validation, ordering |
| **Map** | `lookup`, `merge`, `keys` | Configuration management |
| **Numeric** | `max`, `min`, `sum` | Calculations, limits |
| **Date/Time** | `timestamp`, `formatdate` | Timestamps, scheduling |
| **Conditional** | `?:`, `coalesce`, `try` | Logic, error handling |
| **Collection** | `for`, `flatten`, `distinct` | Data transformation |
| **Encoding** | `base64encode`, `jsonencode` | Data encoding |
| **Network** | `cidrsubnet`, `cidrhost` | IP address management |

## 🎯 **Next Steps**

1. **Practice**: Run this example and explore the outputs
2. **Experiment**: Modify variables and see the changes
3. **Apply**: Use these functions in your own Terraform projects
4. **Reference**: Keep this as a function reference guide

---
**Master these functions and become a Terraform pro! 🚀**
