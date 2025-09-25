# Outputs to show what the provisioners created
output "created_files" {
  description = "List of files created by provisioners"
  value = [
    local_file.demo_file.filename,
    local_file.config_file.filename,
    local_file.test_file.filename,
    local_file.script_file.filename
  ]
}

output "demo_file_content" {
  description = "Content of the demo file"
  value       = local_file.demo_file.content
}

output "config_file_content" {
  description = "Content of the config file (parsed JSON)"
  value       = jsondecode(local_file.config_file.content)
}

output "provisioner_summary" {
  description = "Summary of provisioner demonstrations"
  value = {
    app_name           = var.app_name
    environment        = var.environment
    app_version        = var.app_version
    total_files_created = 4
    provisioner_types = [
      "local-exec with bash",
      "local-exec with PowerShell", 
      "local-exec with working directory",
      "local-exec with failure handling",
      "local-exec with destroy hook",
      "null_resource provisioners"
    ]
    log_files_created = [
      "provisioner-log.txt",
      "provisioner-powershell-log.txt", 
      "deployment.log",
      "provisioner-results.txt",
      "demo-setup.txt"
    ]
  }
}