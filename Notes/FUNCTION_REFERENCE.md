# 📋 Terraform Functions Quick Reference Card

## 🔤 **String Functions**
```hcl
upper("hello")           # "HELLO"
lower("HELLO")           # "hello"
title("hello world")     # "Hello World"
length("hello")          # 5
substr("hello", 0, 3)    # "hel"
replace("hello", "l", "x") # "hexxo"
join(",", ["a", "b"])    # "a,b"
split(",", "a,b")        # ["a", "b"]
trimspace("  hello  ")   # "hello"
```

## 📋 **List Functions**
```hcl
length([1, 2, 3])        # 3
element([1, 2, 3], 1)    # 2
contains([1, 2, 3], 2)   # true
index([1, 2, 3], 2)      # 1
concat([1, 2], [3, 4])   # [1, 2, 3, 4]
sort(["c", "a", "b"])    # ["a", "b", "c"]
reverse([1, 2, 3])       # [3, 2, 1]
slice([1, 2, 3, 4], 1, 3) # [2, 3]
```

## 🗺️ **Map Functions**
```hcl
keys({a = 1, b = 2})     # ["a", "b"]
values({a = 1, b = 2})   # [1, 2]
lookup({a = 1}, "a", 0)  # 1
lookup({a = 1}, "b", 0)  # 0 (default)
merge({a = 1}, {b = 2})  # {a = 1, b = 2}
zipmap(["a", "b"], [1, 2]) # {a = 1, b = 2}
```

## 🔢 **Numeric Functions**
```hcl
max(1, 2, 3)             # 3
min(1, 2, 3)             # 1
sum([1, 2, 3])           # 6
abs(-5)                  # 5
ceil(3.2)                # 4
floor(3.8)               # 3
round(3.6)               # 4
```

## ⏰ **Date/Time Functions**
```hcl
timestamp()              # "2025-01-15T10:30:00Z"
formatdate("YYYY-MM-DD", timestamp()) # "2025-01-15"
formatdate("DD/MM/YYYY", timestamp()) # "15/01/2025"
```

## ❓ **Conditional Functions**
```hcl
condition ? true_val : false_val  # Ternary operator
coalesce(null, "", "default")     # "default"
try(risky_operation, "fallback")  # Error handling
can(expression)                   # true if expression works
```

## 📦 **Collection Functions**
```hcl
flatten([["a"], ["b", "c"]])      # ["a", "b", "c"]
distinct(["a", "b", "a"])         # ["a", "b"]
compact(["", "a", "", "b"])       # ["a", "b"]
setintersection([1,2,3], [2,3,4]) # [2, 3]
setunion([1,2], [3,4])            # [1, 2, 3, 4]
```

## 🔐 **Encoding Functions**
```hcl
base64encode("hello")     # "aGVsbG8="
base64decode("aGVsbG8=") # "hello"
jsonencode({a = 1})      # "{\"a\":1}"
jsondecode("{\"a\":1}")  # {a = 1}
urlencode("hello world") # "hello%20world"
```

## 🌐 **Network Functions**
```hcl
cidrsubnet("10.0.0.0/16", 8, 1)  # "10.0.1.0/24"
cidrhost("10.0.0.0/24", 5)       # "10.0.0.5"
cidrnetmask("10.0.0.0/24")        # "255.255.255.0"
```

## 🎯 **Advanced Functions**
```hcl
range(1, 4)              # [1, 2, 3]
chunklist([1,2,3,4,5], 2) # [[1,2], [3,4], [5]]

# For expressions
[for i in [1, 2, 3] : i * 2]     # [2, 4, 6]
{for k, v in {a=1, b=2} : k => v*2} # {a=2, b=4}

# Template functions
templatefile("file.tpl", {var = "value"})
```

## 💡 **Common Patterns**

### **Safe Map Access**
```hcl
instance_type = lookup(var.instance_types, var.env, "t2.micro")
```

### **Dynamic Resource Names**
```hcl
name = "${var.project}-${var.env}-${formatdate("YYYYMMDD", timestamp())}"
```

### **Conditional Instance Types**
```hcl
instance_type = var.env == "prod" ? "t3.large" : "t2.micro"
```

### **Merge Common Tags**
```hcl
tags = merge(var.common_tags, {
  Name = local.resource_name
  CreatedAt = timestamp()
})
```

### **Generate Subnet CIDRs**
```hcl
subnet_cidrs = [for i in range(3) : cidrsubnet(var.vpc_cidr, 8, i)]
```

---
**💾 Save this reference card for quick function lookups! 🚀**
