variable "file_name" {
  default     = "iac.txt"
  type        = string
  description = "value for the file name"
}

variable "content" {
  default     = "AWS is great!"
  type        = string
  description = "content for the file"
}