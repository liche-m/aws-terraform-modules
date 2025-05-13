terraform {
  required_version = ">= 1.9.8"

  required_providers {
    local = {
      source  = "hashicorp/local"
      version = ">= 2.5.2"
    }
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.94.1"
    }
  }
}
