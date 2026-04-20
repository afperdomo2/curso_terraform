variable "name_prefix" {
  type        = string
  description = "Prefijo para nombrar los recursos"
}

variable "vpc_id" {
  type        = string
  description = "ID de la VPC donde crear el security group"
}

variable "common_tags" {
  type        = map(string)
  description = "Mapa de etiquetas comunes a aplicar en todos los recursos"
  default     = {}
}
