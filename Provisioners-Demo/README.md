# 🔧 Terraform Provisioners Demo - Simple Guide

This directory demonstrates **Terraform Provisioners** with simple, easy-to-understand examples!

## 🎯 **What Are Provisioners?**

Provisioners are used to **execute commands** or **run scripts** on resources after they're created or before they're destroyed.

### **⚠️ Important Note:**
Provisioners are a **last resort**. HashiCorp recommends using them only when no other option exists. Better alternatives include:
- Cloud-init scripts
- Configuration management tools (Ansible, Chef, Puppet)
- Custom AMIs/images

## 📋 **Types of Provisioners Demonstrated**

### 1. **`local-exec`** - Runs commands on the Terraform machine
```hcl
provisioner "local-exec" {
  command = "echo 'Hello World' >> output.txt"
}
```

### 2. **PowerShell Integration** - Windows-specific commands
```hcl
provisioner "local-exec" {
  command     = "Write-Output 'Hello from PowerShell'"
  interpreter = ["powershell", "-Command"]
}
```

### 3. **Failure Handling** - Continue on errors
```hcl
provisioner "local-exec" {
  command    = "might-fail-command"
  on_failure = continue  # Don't stop if this fails
}
```

### 4. **Destroy Provisioners** - Run during destruction
```hcl
provisioner "local-exec" {
  when    = destroy
  command = "echo 'Cleaning up...'"
}
```

### 5. **null_resource** - Provisioners without infrastructure
```hcl
resource "null_resource" "setup" {
  provisioner "local-exec" {
    command = "echo 'Setup complete'"
  }
}
```

## 🚀 **How to Use This Demo**

### **Step 1: Navigate to the directory**
```powershell
cd "s:\Computron\Terraform\Provisioners-Demo"
```

### **Step 2: Initialize Terraform**
```powershell
terraform init
```

### **Step 3: Apply the configuration**
```powershell
terraform apply
```

### **Step 4: Check the generated files**
The provisioners will create several files:
- `provisioner-log.txt` - Basic command output
- `provisioner-powershell-log.txt` - PowerShell output
- `deployment.log` - Environment-specific deployment log
- `demo-setup.txt` - Setup information
- `deploy-script.ps1` - Generated PowerShell script
- `my-demo-app-development/` - Application directory

### **Step 5: Test destroy provisioners**
```powershell
terraform destroy
```
This will trigger the destroy provisioners and create `cleanup-log.txt`.

## 📝 **What Each Resource Demonstrates**

### **`local_file.demo_file`**
- Basic `local-exec` provisioner
- PowerShell provisioner with interpreter
- Working directory specification
- Failure handling with `on_failure = continue`

### **`local_file.config_file`**
- Conditional commands based on environment
- JSON validation using PowerShell
- Dynamic content generation

### **`local_file.test_file`**  
- Multiple provisioners on one resource
- Success and failure scenarios
- Destroy provisioner (runs during `terraform destroy`)

### **`null_resource.setup_demo`**
- Provisioners without creating actual infrastructure
- Multi-line PowerShell scripts
- Trigger-based re-execution

### **`local_file.script_file`**
- Template-based script generation
- Complex PowerShell script creation
- File provisioner alternative

## 💡 **Key Learning Points**

### **1. Provisioners Run After Resource Creation**
```hcl
resource "local_file" "example" {
  filename = "test.txt"
  content  = "Hello"
  
  # This runs AFTER the file is created
  provisioner "local-exec" {
    command = "echo 'File created: ${self.filename}'"
  }
}
```

### **2. Use `self` to Reference the Resource**
```hcl
provisioner "local-exec" {
  command = "echo 'Created: ${self.filename}'"
  #                          ↑
  #                    References this resource
}
```

### **3. Different Interpreters for Different Commands**
```hcl
# Bash/CMD
provisioner "local-exec" {
  command = "echo 'Hello'"
}

# PowerShell
provisioner "local-exec" {
  command     = "Write-Output 'Hello'"
  interpreter = ["powershell", "-Command"]
}
```

### **4. Error Handling Options**
```hcl
provisioner "local-exec" {
  command    = "risky-command"
  on_failure = continue  # Options: fail (default), continue
}
```

## 🎮 **Try These Experiments**

### **1. Change the Environment**
Edit `terraform.tfvars`:
```hcl
environment = "production"  # Changes provisioner behavior
```

### **2. Modify the App Name**
```hcl
app_name = "my-awesome-app"  # See how it affects generated files
```

### **3. Test Failure Handling**
Look at the provisioner that runs `nonexistent-command-that-will-fail` - it continues despite failing!

### **4. Run Multiple Times**
The `null_resource` has `triggers = { always_run = timestamp() }`, so it runs every time!

## 🧹 **Clean Up**

When you're done exploring:
```powershell
terraform destroy
```

This will:
1. Run the destroy provisioners (creating cleanup logs)
2. Remove all created files
3. Clean up the demonstration

## ⚠️ **Best Practices Reminder**

1. **Use provisioners sparingly** - They make Terraform less predictable
2. **Prefer cloud-native solutions** - cloud-init, user data, etc.
3. **Handle failures gracefully** - Use `on_failure = continue` when appropriate
4. **Keep commands simple** - Complex logic belongs in separate scripts
5. **Test destroy provisioners** - Make sure cleanup works properly

---
**Happy learning! This demo shows you everything you need to know about Terraform provisioners! 🚀**
