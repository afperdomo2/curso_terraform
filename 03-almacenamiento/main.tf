terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.41.0"
    }
  }
}

provider "aws" {
  region = var.region
}

resource "aws_s3_bucket" "s3-assets" {
  bucket        = "${var.org_name}-${var.project_name}-${var.environment}-assets"
  force_destroy = true # Permite eliminar el bucket aunque tenga objetos dentro
  tags          = local.common_tags
}
