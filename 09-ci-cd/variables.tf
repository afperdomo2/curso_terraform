variable "region" {
  type        = string
  default     = "us-east-1"
  description = "Región de AWS donde se crearán los recursos"
}

variable "org_name" {
  type        = string
  default     = "felipecorp"
  description = "Nombre de la organización a la que pertenecen los recursos"
}

variable "project_name" {
  type        = string
  default     = "tfcourse"
  description = "Nombre del proyecto al que pertenecen los recursos"
}

variable "environment" {
  type        = string
  default     = "dev"
  description = "Entorno de despliegue (dev, staging, prod)"
}
