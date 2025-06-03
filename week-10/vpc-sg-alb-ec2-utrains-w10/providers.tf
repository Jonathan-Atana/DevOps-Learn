terraform {
  backend "s3" {
    bucket  = var.bucket
    key     = "dev/w10/terraform.tfstate"
    region  = var.region
    encrypt = true
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.98.0"
    }
  }
}

provider "aws" {
  region = var.region
}