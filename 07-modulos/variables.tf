variable "region" {
  type        = string
  default     = "us-east-1"
  description = "Región de AWS donde se crearán los recursos"
}

variable "org_name" {
  type        = string
  default     = "felipecorp"
  description = "Nombre de la organización"
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
  description = "Nombre del par de claves SSH para acceder a las instancias EC2"
}

variable "instance_type" {
  type        = string
  default     = "t3.micro"
  description = "Tipo de instancia EC2"
}

variable "instance_count" {
  type        = number
  default     = 1
  description = "Número de instancias EC2 a crear"
}
