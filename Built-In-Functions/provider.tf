terraform {
  required_version = ">= 0.14"
  
  required_providers {
    local = {
      source  = "hashicorp/local"
      version = "~> 2.0"
    }
  }
}
