terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.41.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "s3-assets" {
  bucket        = "${var.org_name}-${var.project_name}-${var.environment}-demo-ci-cd"
  force_destroy = true
  tags = {
    organization = var.org_name
    project      = var.project_name
    environment  = var.environment
    owner        = "felipe"
    created_by   = "terraform"
  }
}
