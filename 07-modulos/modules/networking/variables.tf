variable "name_prefix" {
  type        = string
  description = "Prefijo para nombrar los recursos (ej: project-environment)"
}

variable "vpc_cidr" {
  type        = string
  description = "Bloque CIDR para la VPC"
  default     = "10.0.0.0/16"
}

variable "subnet_cidr" {
  type        = string
  description = "Bloque CIDR para la subnet pública"
  default     = "10.0.1.0/24"
}

variable "availability_zone" {
  type        = string
  description = "Zona de disponibilidad donde crear la subnet"
}

variable "common_tags" {
  type        = map(string)
  description = "Mapa de etiquetas comunes a aplicar en todos los recursos"
  default     = {}
}
