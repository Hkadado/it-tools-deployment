terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "s3" {
    bucket  = "hasan-it-tools-tf-state-820242908024-us-east-1-an"
    key     = "it-tools-app/terraform.tfstate"
    region  = "us-east-1"
    encrypt = true
  }
}