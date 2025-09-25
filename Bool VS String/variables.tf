variable "file_name" {
  default     = true 
  # The argument expects a string but is set to a boolean value, 
  # thus this will be converted from a bool to a string value. 
  # While Terraform allows it (type coercion), it's misleading and can introduce subtle bugs in your infrastructure.
  type        = bool
  description = "value for the file name"
}

variable "content" {
  default     = "AWS is great!"
  type        = string
  description = "content for the file"
}