variable "environment" {
  description = "Environment name for demonstrations"
  type        = string
  default     = "development"
  validation {
    condition     = contains(["development", "staging", "production"], var.environment)
    error_message = "Environment must be development, staging, or production."
  }
}

variable "project_name" {
  description = "Name of the project"
  type        = string
  default     = "functions-demo"
}

variable "enable_advanced_examples" {
  description = "Enable advanced function examples"
  type        = bool
  default     = true
}

variable "sample_list" {
  description = "Sample list for function demonstrations"
  type        = list(string)
  default     = ["apple", "banana", "cherry", "date"]
}

variable "sample_map" {
  description = "Sample map for function demonstrations"
  type        = map(string)
  default = {
    color  = "blue"
    size   = "large"
    type   = "primary"
    status = "active"
  }
}

variable "sample_numbers" {
  description = "Sample numbers for numeric functions"
  type        = list(number)
  default     = [10, 25, 5, 40, 15]
}
