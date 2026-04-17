terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.41.0"
    }
  }
  backend "s3" {
    key          = "terraform.tfstate" # Ruta y nombre del archivo de estado
    region       = ""                  # Región del bucket
    bucket       = ""                  # Bucket de S3 donde se almacena el estado
    use_lockfile = true                # Esto reemplaza a dynamodb_table
    encrypt      = true                # Cifrado del estado en S3
  }
}

provider "aws" {
  region = "us-east-1"
}

