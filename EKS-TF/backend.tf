terraform {
  backend "s3" {
    bucket         = "tetris-bucket"
    region         = "ap-south-1"
    key            = "EKS-DevSecOps-Tetris-Project/EKS-TF/terraform.tfstate"
    dynamodb_table = "Lock-Files"
    encrypt        = true
  }
  required_version = ">=0.13.0"
  required_providers {
    aws = {
      version = ">= 1.7.4"
      source  = "hashicorp/aws"
    }
  }
}
