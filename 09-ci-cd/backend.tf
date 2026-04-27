terraform {
  backend "s3" {
    key          = "terraform/ci-cd/terraform.tfstate" # Ruta y nombre del archivo de estado
    region       = "us-east-1"                         # Región del bucket
    bucket       = ""                                  # Bucket de S3 donde se almacena el estado
    use_lockfile = true                                # Esto reemplaza a dynamodb_table
    encrypt      = true                                # Cifrado del estado en S3
  }
}
