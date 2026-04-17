variable "region" {
  type        = string
  default     = "us-east-1"
  description = "Región de AWS donde se crearán los recursos"
}

variable "project_name" {
  type        = string
  default     = "curso_terraform"
  description = "Nombre del proyecto"
}

variable "created_by" {
  type        = string
  default     = "terraform"
  description = "Nombre del creador de los recursos"
}

variable "app_name" {
  type        = string
  default     = "clase_02_outputs"
  description = "Nombre de la aplicación Terraform"
}

