resource "local_file" "demo_file" {
  filename = "./provisioner-demo.txt"
  content  = "Initial content created by Terraform"

  # Local-exec provisioner - runs commands on the machine running Terraform
  provisioner "local-exec" {
    command = "echo 'File created at: ${self.filename}' >> ./provisioner-log.txt"
  }

  # Another local-exec example with PowerShell (Windows)
  provisioner "local-exec" {
    command     = "Write-Output 'Created file: ${self.filename}' | Out-File -Append provisioner-powershell-log.txt"
    interpreter = ["powershell", "-Command"]
  }

  # Local-exec with working directory
  provisioner "local-exec" {
    command         = "echo 'Working from custom directory' > custom-dir-output.txt"
    working_dir     = var.working_directory
    on_failure      = continue  # Continue even if this fails
  }
}

# Another file to demonstrate multiple provisioners
resource "local_file" "config_file" {
  filename = "./app-config.json"
  content = jsonencode({
    app_name    = var.app_name
    environment = var.environment
    created_at  = timestamp()
    version     = var.app_version
  })

  # Run different commands based on the environment
  provisioner "local-exec" {
    command = var.environment == "production" ? "echo 'Production deployment completed!' >> deployment.log" : "echo 'Development deployment completed!' >> deployment.log"
  }

  # Validate the created JSON file
  provisioner "local-exec" {
    command = "powershell -Command \"Get-Content '${self.filename}' | Test-Json; if ($?) { Write-Output 'JSON is valid' } else { Write-Output 'JSON is invalid'; exit 1 }\""
    interpreter = ["cmd", "/C"]
  }
}

# File that demonstrates provisioner failure handling
resource "local_file" "test_file" {
  filename = "./test-output.txt"
  content  = "Test file for provisioner demonstrations"

  # This provisioner will succeed
  provisioner "local-exec" {
    command = "echo 'Success: Test file created successfully' >> ./provisioner-results.txt"
  }

  # This provisioner might fail but we'll continue
  provisioner "local-exec" {
    command    = "nonexistent-command-that-will-fail"
    on_failure = continue
  }

  # This will run regardless of the previous failure
  provisioner "local-exec" {
    command = "echo 'Continuing after potential failure' >> ./provisioner-results.txt"
  }

  # Cleanup provisioner - runs when resource is destroyed
  provisioner "local-exec" {
    when    = destroy
    command = "echo 'Cleaning up: ${self.filename}' >> ./cleanup-log.txt"
  }
}

# Demonstrate null_resource for running provisioners without creating infrastructure
resource "null_resource" "setup_demo" {
  # This will run every time due to the timestamp trigger
  triggers = {
    always_run = timestamp()
  }

  # Create a setup script
  provisioner "local-exec" {
    command = <<-EOT
      echo "=== Terraform Provisioners Demo Setup ===" > ./demo-setup.txt
      echo "Setup completed at: $(Get-Date)" >> ./demo-setup.txt
      echo "Environment: ${var.environment}" >> ./demo-setup.txt
      echo "App Name: ${var.app_name}" >> ./demo-setup.txt
    EOT
    interpreter = ["powershell", "-Command"]
  }

  # Create a simple PowerShell script file
  provisioner "local-exec" {
    command = <<-EOT
      @'
Write-Host "Hello from generated PowerShell script!"
Write-Host "Environment: ${var.environment}"
Write-Host "App: ${var.app_name}"
Write-Host "Current time: $(Get-Date)"
'@ | Out-File -FilePath "./generated-script.ps1" -Encoding UTF8
    EOT
    interpreter = ["powershell", "-Command"]
  }
}

# Demonstrate file provisioner alternative using local_file
resource "local_file" "script_file" {
  filename = "./deploy-script.ps1"
  content = templatefile("${path.module}/deploy-template.ps1.tftpl", {
    app_name    = var.app_name
    environment = var.environment
    app_version = var.app_version
  })

  # Make the script executable and run it
  provisioner "local-exec" {
    command     = "./deploy-script.ps1"
    interpreter = ["powershell", "-File"]
  }
}
