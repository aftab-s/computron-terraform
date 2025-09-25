variable "app_name" {
  description = "Name of the application"
  type        = string
  default     = "demo-app"
}

variable "environment" {
  description = "Environment name (dev, staging, prod)"
  type        = string
  default     = "development"
  validation {
    condition     = contains(["development", "staging", "production"], var.environment)
    error_message = "Environment must be development, staging, or production."
  }
}

variable "app_version" {
  description = "Version of the application"
  type        = string
  default     = "1.0.0"
}

variable "working_directory" {
  description = "Working directory for provisioner commands"
  type        = string
  default     = "."
}

variable "enable_cleanup" {
  description = "Enable cleanup provisioners"
  type        = bool
  default     = true
}

variable "log_level" {
  description = "Logging level for provisioners"
  type        = string
  default     = "INFO"
  validation {
    condition     = contains(["DEBUG", "INFO", "WARN", "ERROR"], var.log_level)
    error_message = "Log level must be DEBUG, INFO, WARN, or ERROR."
  }
}
