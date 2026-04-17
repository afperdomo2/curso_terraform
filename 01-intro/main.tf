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

resource "aws_iam_user" "app_server" {
  name = "${var.app_name}-test-user"
  tags = {
    "proyecto"   = var.project_name
    "creado_por" = var.created_by
  }
}
