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
  description = "Nombre del proyecto para etiquetar los recursos"
}

variable "environment" {
  type        = string
  default     = "dev"
  description = "Entorno de despliegue (dev, staging, prod)"
}

variable "key_name" {
  type        = string
  description = "Nombre del par de claves para acceder a las instancias EC2"
}
