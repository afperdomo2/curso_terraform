variable "region" {
  type        = string
  default     = "us-east-1"
  description = "Región de AWS donde se crearán los recursos"
}

variable "project_name" {
  type        = string
  default     = "tfcourse"
  description = "Nombre del proyecto para etiquetar los recursos"
}

variable "enviroment" {
  type        = string
  default     = "staging"
  description = "Entorno de despliegue (dev, staging, prod)"
}

variable "created_by" {
  type        = string
  default     = "felipe"
  description = "Nombre del creador de los recursos para etiquetado"
}
