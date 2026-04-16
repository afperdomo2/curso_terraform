terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.41.0"
    }
  }
}

provider "aws" {
  # Configuration options
}

resource "aws_iam_user" "app_server" {
  name = "curso_terraform-test-user"
}
