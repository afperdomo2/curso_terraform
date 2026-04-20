locals {
  # Etiquetas que comparten TODOS los recursos
  common_tags = {
    Organization = var.org_name
    Project      = var.project_name
    Environment  = var.environment
    Owner        = "felipe"
    CreatedBy    = "terraform"
  }
}
