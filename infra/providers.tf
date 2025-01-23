terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 5.82.2"
    }

    archive = {
      source = "hashicorp/archive"
      version = "~> 2.7.0"
    }
  }

  backend "s3" {
    bucket = "resume-bucket-terraform-state"
    key = "state"
    region = "ap-southeast-1"
  }

  required_version = ">= 1.10"
}

provider "aws" {
  region = "ap-southeast-1"
}

provider "aws" {
  region = "us-east-1"
  alias = "ue1"
}