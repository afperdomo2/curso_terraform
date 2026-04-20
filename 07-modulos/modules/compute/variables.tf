variable "name_prefix" {
  type        = string
  description = "Prefijo para nombrar los recursos"
}

variable "instance_type" {
  type        = string
  description = "Tipo de instancia EC2"
  default     = "t3.micro"
}

variable "instance_count" {
  type        = number
  description = "Número de instancias EC2 a crear"
  default     = 1
}

variable "subnet_id" {
  type        = string
  description = "ID de la subnet donde lanzar las instancias"
}

variable "security_group_ids" {
  type        = list(string)
  description = "Lista de IDs de security groups a asociar a las instancias"
}

variable "key_name" {
  type        = string
  description = "Nombre del par de claves SSH para acceder a las instancias"
}

variable "root_volume_size" {
  type        = number
  description = "Tamaño en GB del disco raíz de la instancia"
  default     = 8
}

variable "common_tags" {
  type        = map(string)
  description = "Mapa de etiquetas comunes a aplicar en todos los recursos"
  default     = {}
}
