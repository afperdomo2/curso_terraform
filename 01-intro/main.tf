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

resource "aws_iam_user" "app_server" {
  name = "curso-terraform-test-user"
  tags = {
    "proyecto"   = "curso_terraform"
    "creado_por" = "terraform"
  }
}
