# 📋 Terraform Provisioners Quick Reference

## 🎯 **Basic Provisioner Types**

### **Local-Exec Provisioner**
Runs commands on the machine running Terraform:

```hcl
resource "aws_instance" "web" {
  # ... resource configuration ...
  
  provisioner "local-exec" {
    command = "echo 'Instance created!'"
  }
}
```

### **Remote-Exec Provisioner** (not in this demo)
Runs commands on the remote resource:

```hcl
provisioner "remote-exec" {
  inline = [
    "sudo apt-get update",
    "sudo apt-get install -y nginx"
  ]
  
  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("~/.ssh/id_rsa")
    host        = self.public_ip
  }
}
```

### **File Provisioner** (not in this demo)
Copies files to the remote resource:

```hcl
provisioner "file" {
  source      = "app.conf"
  destination = "/etc/myapp.conf"
  
  connection {
    # ... connection details ...
  }
}
```

## 🔧 **Provisioner Options**

### **Interpreters**
```hcl
# Default (bash on Linux, cmd on Windows)
provisioner "local-exec" {
  command = "echo 'Hello'"
}

# PowerShell
provisioner "local-exec" {
  command     = "Write-Output 'Hello'"
  interpreter = ["powershell", "-Command"]
}

# Custom interpreter
provisioner "local-exec" {
  command     = "print('Hello')"
  interpreter = ["python", "-c"]
}
```

### **Working Directory**
```hcl
provisioner "local-exec" {
  command     = "ls -la"
  working_dir = "/tmp"
}
```

### **Environment Variables**
```hcl
provisioner "local-exec" {
  command = "echo $MY_VAR"
  environment = {
    MY_VAR = "Hello World"
  }
}
```

### **Error Handling**
```hcl
provisioner "local-exec" {
  command    = "risky-command"
  on_failure = continue  # Options: fail (default), continue
}
```

## ⏰ **When Provisioners Run**

### **Creation Time (default)**
```hcl
provisioner "local-exec" {
  command = "echo 'Resource created'"
  # Runs after resource is created
}
```

### **Destroy Time**
```hcl
provisioner "local-exec" {
  when    = destroy
  command = "echo 'Resource being destroyed'"
  # Runs before resource is destroyed
}
```

## 🎯 **Self References**

Access the current resource's attributes:

```hcl
resource "aws_instance" "web" {
  # ... configuration ...
  
  provisioner "local-exec" {
    command = "echo 'Instance ID: ${self.id}'"
    command = "echo 'Public IP: ${self.public_ip}'"
    command = "echo 'Private IP: ${self.private_ip}'"
  }
}
```

## 🚫 **null_resource for Provisioner-Only Resources**

When you need provisioners without actual infrastructure:

```hcl
resource "null_resource" "setup" {
  # Triggers determine when to re-run
  triggers = {
    cluster_instance_ids = join(",", aws_instance.cluster.*.id)
    # Or always run: always_run = timestamp()
  }
  
  provisioner "local-exec" {
    command = "kubectl apply -f k8s-config.yaml"
  }
}
```

## 💡 **Best Practices**

### **✅ DO:**
- Use provisioners as a last resort
- Keep commands simple and idempotent
- Handle failures gracefully with `on_failure = continue`
- Use `null_resource` for standalone provisioning tasks
- Test destroy provisioners

### **❌ DON'T:**
- Use provisioners for complex configuration management
- Rely on provisioners for critical deployment steps
- Put secrets directly in commands (use environment variables)
- Make provisioners dependent on external state

## 🔄 **Better Alternatives**

Instead of provisioners, consider:

1. **Cloud-Init / User Data**
   ```hcl
   user_data = base64encode(templatefile("setup.sh", {}))
   ```

2. **Custom AMIs/Images**
   - Pre-bake software into images
   - Use Packer to build images

3. **Configuration Management**
   - Ansible, Chef, Puppet
   - Run after Terraform completes

4. **Container Images**
   - Docker with pre-configured applications
   - Kubernetes with init containers

## 🎮 **Common Patterns**

### **Conditional Provisioners**
```hcl
provisioner "local-exec" {
  command = var.environment == "production" ? 
           "deploy-production.sh" : 
           "deploy-dev.sh"
}
```

### **Multi-line Scripts**
```hcl
provisioner "local-exec" {
  command = <<-EOT
    echo "Starting deployment..."
    ./deploy.sh
    echo "Deployment complete!"
  EOT
}
```

### **Dependency Management**
```hcl
resource "null_resource" "dependency" {
  depends_on = [aws_instance.web, aws_db_instance.db]
  
  provisioner "local-exec" {
    command = "configure-app.sh"
  }
}
```

---
**💾 Use this as your quick reference for Terraform provisioners! 🚀**
